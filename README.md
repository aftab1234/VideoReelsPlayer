# VideoReelsPlayer
A project like tik tok and instagram reels

## ✨ Features

- **Full-Screen Reels View**  
  Rotated layout to mimic vertical scrolling video playback.
  Class name is ReelsView

- **Single Video Player View**
  - class name is SingleVideoPlayerView
  - Autoplay on appear  
  - Pauses/resumes with app lifecycle  
  - Plays next video automatically after completion  
  - Includes a seekbar

- **Home View**  
  Lists thumbnails of videos. Tapping on a thumbnail presents the full-screen `ReelsView`.
  Class name is HomeView

- **MVVM Architecture**  
  - Video is Model class
  - VideoPlayerVM is model view model class for Reels View
  - PlayerVM is view model class of SingleVideoPlayerView



