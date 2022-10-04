extends AudioStreamPlayer

var current_music_name = "";

# register and preload your music streams here:
const music_streams = {
	"kronenberg": preload("res://assets/music/kronenberg_theme.ogg"),
	"maintheme": preload("res://assets/music/maintheme.ogg")
};

func play_music(music_name:String):
	if current_music_name == music_name:
		return;
	
	stop();
	
	current_music_name = music_name;
	stream = music_streams.get(music_name);
	
	play();
	
func register_stream(stream_path:String, music_name:String):
	music_streams[music_name] = load(stream_path);
