import Foundation
import AVFoundation

public actor AudioPlayer {

	private var player: AVAudioPlayer?

	public func play() {
		guard let audioFile = Bundle.main.path(forResource: "oxp", ofType: "wav") else {
			return
		}
		do {
			let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFile))
			self.player = player
			player.play()
		} catch let error {
			print("Cannot play sound. \(error.localizedDescription)")
		}
	}

	public func stop() {
		player?.stop()
	}

	public init() {}
}
