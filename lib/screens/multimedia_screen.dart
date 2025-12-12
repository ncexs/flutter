import 'package:flutter/material.dart';
// Import library untuk memutar audio
import 'package:audioplayers/audioplayers.dart';
// Import library dasar untuk memutar video
import 'package:video_player/video_player.dart';
// Import library untuk tampilan kontrol video (Play, Pause, Fullscreen, dll)
import 'package:chewie/chewie.dart';

class MultimediaScreen extends StatelessWidget {
  const MultimediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController digunakan untuk membuat tab (Audio & Video)
    return DefaultTabController(
      length: 2, // Jumlah Tab ada 2
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Multimedia Player"),
          // Mengambil warna utama dari tema aplikasi
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          // Membuat TabBar di bagian bawah AppBar
          bottom: const TabBar(
            labelColor: Colors.white, // Warna teks tab aktif
            unselectedLabelColor: Colors.white70, // Warna teks tab tidak aktif
            indicatorColor: Colors.white, // Garis bawah tab aktif
            tabs: [
              Tab(icon: Icon(Icons.audiotrack), text: "Audio"),
              Tab(icon: Icon(Icons.videocam), text: "Video"),
            ],
          ),
        ),
        // TabBarView adalah tempat konten berganti sesuai tab yang dipilih
        body: const TabBarView(
          children: [
            AudioPlayerTab(), // Konten Tab 1
            VideoPlayerTab(), // Konten Tab 2
          ],
        ),
      ),
    );
  }
}

// =======================================================
// BAGIAN 1: AUDIO PLAYER (Tab Audio)
// =======================================================
class AudioPlayerTab extends StatefulWidget {
  const AudioPlayerTab({super.key});

  @override
  State<AudioPlayerTab> createState() => _AudioPlayerTabState();
}

class _AudioPlayerTabState extends State<AudioPlayerTab> {
  // 1. Deklarasi variabel AudioPlayer
  late AudioPlayer _audioPlayer;

  // 2. Variabel untuk menyimpan status (Apakah sedang Play, Stop, atau Pause)
  // Defaultnya kita set 'stopped'
  PlayerState _playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    // Inisialisasi: Membuat instance AudioPlayer saat halaman dibuka
    _audioPlayer = AudioPlayer();

    // Listener: Mendengarkan perubahan status player secara real-time
    // Jika musik selesai atau dipause, variabel _playerState akan ikut berubah
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  void dispose() {
    // PENTING: Matikan player saat keluar dari halaman agar memori tidak bocor
    _audioPlayer.dispose();
    super.dispose();
  }

  // --- Fungsi-fungsi Kontrol Audio ---

  // Fungsi Play
  void _playAudio() async {
    // AssetSource artinya mengambil file dari folder assets project
    await _audioPlayer.play(AssetSource('audio/music.mp3'));
  }

  // Fungsi Pause
  void _pauseAudio() async {
    await _audioPlayer.pause();
  }

  // Fungsi Stop
  void _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gambar Cover Album (Hiasan)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                // Menggunakan gambar background yang sudah ada
                image: AssetImage("assets/img/background2.jpeg"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  // PERBAIKAN DI SINI: Menggunakan .withValues(alpha: ...)
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            // Ikon musik di tengah gambar
            child: const Icon(
              Icons.music_note,
              size: 80,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "Now Playing",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text("music.mp3", style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 30),

          // Baris Tombol Kontrol
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol PLAY
              // Logika: Jika sedang playing, tombol disable (null). Jika tidak, jalankan _playAudio
              ElevatedButton(
                onPressed: _playerState == PlayerState.playing
                    ? null
                    : _playAudio,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Icon(Icons.play_arrow, color: Colors.white),
              ),
              const SizedBox(width: 15),

              // Tombol PAUSE
              ElevatedButton(
                onPressed: _playerState == PlayerState.playing
                    ? _pauseAudio
                    : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Icon(Icons.pause, color: Colors.white),
              ),
              const SizedBox(width: 15),

              // Tombol STOP
              ElevatedButton(
                onPressed: _playerState == PlayerState.stopped
                    ? null
                    : _stopAudio,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Icon(Icons.stop, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 20),
          // Menampilkan teks status (PLAYING / PAUSED / STOPPED)
          Text(
            "Status: ${_playerState.toString().split('.').last.toUpperCase()}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// =======================================================
// BAGIAN 2: VIDEO PLAYER (Tab Video)
// =======================================================
class VideoPlayerTab extends StatefulWidget {
  const VideoPlayerTab({super.key});

  @override
  State<VideoPlayerTab> createState() => _VideoPlayerTabState();
}

class _VideoPlayerTabState extends State<VideoPlayerTab> {
  // Controller dasar untuk memuat video
  late VideoPlayerController _videoPlayerController;
  // Controller tambahan (Chewie) untuk tampilan UI (Play bar, Fullscreen, dll)
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // 1. Inisialisasi video dari Assets
    _videoPlayerController = VideoPlayerController.asset(
      'assets/video/video.mp4',
    );

    // 2. Setelah video berhasil dimuat (initialize), baru kita siapkan Chewie
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio:
              _videoPlayerController.value.aspectRatio, // Sesuaikan rasio video
          autoPlay: false, // Jangan otomatis play
          looping: false, // Jangan mengulang otomatis
          // Pesan error jika video gagal dimuat
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    // PENTING: Hapus controller video dari memori saat keluar
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Cek apakah controller sudah siap?
      child:
          _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              // AspectRatio memastikan video tidak gepeng/terpotong
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                // Widget Chewie menampilkan video player lengkap dengan tombolnya
                child: Chewie(controller: _chewieController!),
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loading spinner saat video sedang disiapkan
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Memuat Video..."),
              ],
            ),
    );
  }
}
