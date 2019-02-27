//
//  KKSimplePlayer.swift
//  playground
//
//  Created by tree on 2018/10/15.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import CoreAudio
import AudioToolbox

class KKSimplePlayer : NSObject {
    var url: URL
    
    var packets = [Data]()
    
    /// 音频流id
    var audioFileStreamID: AudioFileStreamID? = nil
    
    /// 音频队列
    var outputQueue: AudioQueueRef? = nil
    
    var discontinuous: Bool = false
    
    /// ============
    /// 音频总字节数
    var audioDataByteCount: Int32 = 0
    
    /// 字节码率
    var bitRate: UInt32 = 0
    
    /// 时长
    var duration: TimeInterval = 0.0
    
    /// 文件大小
    var fileSize: CUnsignedLongLong = 0
    
    /// 最大packet大小
    var maxPacketSize: UInt32 = 0
    
    /// 流描述信息
    var streamDescription: AudioStreamBasicDescription? = nil
    
    /// 每个packet的时长
    private var packetDuration: TimeInterval = 0.0
    
    /// 每秒的帧数
    var framePerSecond: Double {
        get {
            if let streamDesc = self.streamDescription, streamDesc.mFramesPerPacket > 0 {
                return Double(streamDesc.mSampleRate) / Double(streamDesc.mFramesPerPacket)
            }
            return 44100.0 / 1152.0
        }
    }
    
    override init() {
        self.url = URL.init(string: "https://www.baidu.com")!
        super.init()
    }
    
    convenience init(url: URL) {
        self.init()
        self.url = url
        let selfPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        
        // 创建一个AudioFileStream实例
        AudioFileStreamOpen(selfPointer, KKAudioFileSetreamPropertyListener, KKAudioFileStreamPacketsCallback, kAudioFileMP3Type, &self.audioFileStreamID)
        
        if let data = try? Data.init(contentsOf: url) {
            self.fileSize = CUnsignedLongLong(data.count)
            self.parseData(data: data)
        }
    }
    
    deinit {
        closeAudioFileStream()
    }
    
    /// 关闭音频流
    private func closeAudioFileStream() {
        if let q = self.outputQueue,
            let aid = self.audioFileStreamID {
            AudioQueueReset(q)
            AudioFileStreamClose(aid)
            self.audioFileStreamID = nil
        }
    }
}


extension KKSimplePlayer {
    func play() {
        if let q = self.outputQueue {
            AudioQueueStart(q, nil)
        }
    }
    
    func pause() {
        if let q = self.outputQueue {
            AudioQueuePause(q)
        }
    }
    
    func close() {
        closeAudioFileStream()
    }
    
    private func parseData(data: Data) {
        guard let aid = self.audioFileStreamID else { return }
        /// 解析数据
        /*
         最后一个参数是表示是否是连续的数据，如果是连续的则传1
         建议在第一帧解析完成之前和seek的时候传入AudioFileStreamParseFlags.discontinuity
         */
        let r: UInt32 = UInt32(discontinuous == true ? 1 : 0)
        var status: OSStatus = 0
        status = AudioFileStreamParseBytes(aid, UInt32(data.count), [UInt8](data), .init(rawValue: r))
        assert(status == noErr)
        
        enqueueBuffer()
        
        if let q = self.outputQueue {
            status = AudioQueueFlush(q)
            assert(status == noErr)
            
            status = AudioQueueStop(q, false)
            assert(status == noErr)
        }
        
        
    }
    
    /// 将数据入队缓冲区
    func enqueueBuffer() {
        var status: OSStatus = 0
        if let q = self.outputQueue {
            
        }
    }
    
    /// 释放缓冲区
    func relaseBuffer() {
        
    }
    
    /// 创建一个音频序列
    func createAudioQueue(audioStreamDescription: AudioStreamBasicDescription) {
        self.streamDescription = audioStreamDescription
        var status: OSStatus = 0
        
        let selfPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
//        let descPointer = unsafeBitCast(audioStreamDescription, to: UnsafePointer<AudioStreamBasicDescription>.self)
        var audioDesc = audioStreamDescription
        if let q = self.outputQueue {
            status = AudioQueueNewOutput(&audioDesc, KKAudioQueueOutputCallback as! AudioQueueOutputCallback, selfPointer, CFRunLoopGetCurrent(), RunLoopMode.commonModes.rawValue as CFString, 0, &self.outputQueue)
            assert(status == noErr)
            status = AudioQueueAddPropertyListener(q, kAudioQueueProperty_IsRunning, KKAudioQueueRunningListener as! AudioQueuePropertyListenerProc, selfPointer)
            assert(status == noErr)
            AudioQueuePrime(q, 0, nil)
            AudioQueueStart(q, nil)
        }
    }
}

extension KKSimplePlayer {
    /// 解析音频流属性信息
    func handleAudioFileSetreamPropertyListener(audioFileStream: AudioFileStreamID, propertID: AudioFilePropertyID) {
        var dataSize: UInt32 = 0
        var status: OSStatus = 0
        let selfPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        switch propertID {
        case kAudioFileStreamProperty_ReadyToProducePackets:
            var writable: DarwinBoolean = false // DarwinBoolean is mapping of the C Boolean
            /// 获得属性值的信息 但是当前没有可写的文件流属性
            status = AudioFileStreamGetPropertyInfo(audioFileStream, propertID, &dataSize, &writable)
            assert(status == noErr)
            
            /// 获取比特率
            var o: UInt32 = 0
            status = AudioFileStreamGetProperty(audioFileStream, kAudioFileStreamProperty_BitRate, &dataSize, &o)
            if status != noErr { break }
            self.bitRate = o
            print("\(bitRate)")
            
            
            var offset: UInt32 = 0
            status = AudioFileStreamGetProperty(audioFileStream, kAudioFileStreamProperty_DataOffset, &dataSize, &offset)
            if status != noErr { break }
            print("\(offset)")
            
            break
        case kAudioFileStreamProperty_DataFormat:
            var audioStreamDescription: AudioStreamBasicDescription = AudioStreamBasicDescription.init()
            // 获得指定的属性值
            dataSize = UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
            status = AudioFileStreamGetProperty(audioFileStream, propertID, &dataSize, &audioStreamDescription)
            if status != noErr {
                print("cant read AudioStreamBasicDescription")
                break
            }
            self.packetDuration = self.calculatePacketDuration(format: audioStreamDescription)
            print("\(self.packetDuration)")
            
            /// create the audio queue
            self.createAudioQueue(audioStreamDescription: audioStreamDescription)
//            status = AudioQueueNewOutput(&audioStreamDescription, KKAudioQueueOutputCallback as! AudioQueueOutputCallback, selfPointer, CFRunLoopGetCurrent(), RunLoopMode.commonModes.rawValue as CFString, 0, &self.outputQueue)
            if status != noErr {
                break
            }
            break
        default:
            break
        }
    }
    
    /// 把解析的数据存起来
    func handleAudioFileStreamPackets(inputData: UnsafeRawPointer, numberOfBytes: UInt32, numberOfPackets: UInt32, packetDescription: UnsafeMutablePointer<AudioStreamPacketDescription>) {
        for i in 0 ..< Int(numberOfPackets) {
            let currentDesc = packetDescription[i]
            let packetStart = currentDesc.mStartOffset
            let packetSize = currentDesc.mDataByteSize
            let packetData = Data.init(bytes: inputData.advanced(by: Int(packetStart)), count: Int(packetSize))
            self.packets.append(packetData)
        }
        var status: OSStatus = 0
        if let aid = audioFileStreamID {
            /// 解析数据
            status = AudioFileStreamParseBytes(aid, numberOfBytes, inputData, .init(rawValue: 0))
            assert(status == noErr)
        }
        print("\(self.packets.count)")
        
    }
    
    func handleAudioQueueOutputCallback(clientData: UnsafeMutableRawPointer, AQ: AudioQueueRef, buffer: AudioQueueBufferRef) {
        
    }
}

extension KKSimplePlayer {
    func calculateDuration(fileSize: CUnsignedLongLong, bitRate: UInt32, offset: UInt32) -> TimeInterval {
        var duration: TimeInterval = 0.0
        if (fileSize > 0 && bitRate > 0) {
            duration = (Double((Double(fileSize) - Double(offset))) * 8.0) / Double(bitRate)
        }
        return duration
    }
    
    func calculateBitRate(packetDur:  UInt32, processedPacketCount: UInt32, processedPacketSize: UInt32) -> UInt32 {
        var o: UInt32 = 0
        if packetDur > 0
            && processedPacketCount > 10
            && processedPacketCount <= 5000 {
            let avgPacketByteSize = Double(processedPacketSize / processedPacketCount)
            o = UInt32(8.0 * avgPacketByteSize / Double(packetDur))
        }
        return o
    }
    
    func calculatePacketDuration(format: AudioStreamBasicDescription) -> TimeInterval {
        print("\(format)")
        var o = TimeInterval(0.0)
        if format.mSampleRate > 0 {
            o = Double(format.mFramesPerPacket) / Double(format.mSampleRate)
        }
        return o
    }
}

/// 歌曲信息解析的回调
func KKAudioFileSetreamPropertyListener(clientData: UnsafeMutableRawPointer, audioFileStream: AudioFileStreamID, propertID: AudioFilePropertyID, ioFlag: UnsafeMutablePointer<AudioFileStreamPropertyFlags>) {
    let this = Unmanaged<KKSimplePlayer>.fromOpaque(clientData).takeUnretainedValue()
    this.handleAudioFileSetreamPropertyListener(audioFileStream: audioFileStream, propertID: propertID)
}

/// 歌曲帧的解析回调
func KKAudioFileStreamPacketsCallback(clientData: UnsafeMutableRawPointer, numberBytes: UInt32, numberPackets: UInt32, inputData: UnsafeRawPointer, packetDescription: UnsafeMutablePointer<AudioStreamPacketDescription>) {
    /// https://nshipster.cn/unmanaged/
    /// 管理CF框架中的类型
    let this = Unmanaged<KKSimplePlayer>.fromOpaque(clientData).takeUnretainedValue()
    this.handleAudioFileStreamPackets(inputData: inputData, numberOfBytes: numberBytes, numberOfPackets: numberPackets, packetDescription: packetDescription)
}

func KKAudioQueueOutputCallback(clientData: UnsafeMutableRawPointer, AQ: AudioQueueRef, buffer: AudioQueueBufferRef) {
    let this = Unmanaged<KKSimplePlayer>.fromOpaque(clientData).takeUnretainedValue()
    print("KKAudioQueueOutputCallback called")
    AudioQueueFreeBuffer(AQ, buffer)
    
}

func KKAudioQueueRunningListener(clientData: UnsafeMutableRawPointer, AQ: AudioQueueRef, propertyID: AudioQueuePropertyID) {
    let this = Unmanaged<KKSimplePlayer>.fromOpaque(clientData).takeUnretainedValue()
    print("KKAudioQueueRunningListener called")
    
}

