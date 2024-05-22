import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'SecondScree.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with WidgetsBindingObserver {
  final player = AudioPlayer();
  bool isPlaying = false; // Ajouter cette ligne


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlayer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.pause();
      setState(() {
        isPlaying = false;
      });
    } else if (state == AppLifecycleState.resumed) {

        player.play(); // Reprendre la lecture si isPlaying est true

    }
  }

  Future<void> initPlayer() async {
    await player.setAsset('lib/assets/Yanabi_salam_alik.mp3');
    player.play();
    setState(() {
      isPlaying = true; // Définir isPlaying à true après avoir démarré la lecture
    });
  }

  void stopAudio() {
    player.stop();
    setState(() {
      isPlaying = false; // Définir isPlaying à false après avoir arrêté l'audio
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('يؤدي المسلم الصغير خمس صلوات يوميا'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GridItem(index: index);
        },
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  const GridItem({Key? key, required this.index}) : super(key: key);

  static const List<String> imagePaths = [
    'lib/assets/images/enfant.png',
    'lib/assets/images/enfant.png',
    'lib/assets/images/enfant.png',
    'lib/assets/images/enfant.png',
    'lib/assets/images/enfant.png',
  ];

  static const List<String> titles = [
    'صلاة الظهر',
    'صلاة الصبح',
    'صلاة المغرب',
    'صلاة العصر',
    'صلاة العشاء',
  ];

  static const List<String> subtitles = [
    '4',
    '4',
    '3',
    '4',
    '4',
  ];

  static const List<String> etapes = [
    'الوضوء',
    'تكبيرة الاحرام',
    'السجود',
    'الرفع من السجود',
  ];

  void navigateToSecondScreen(BuildContext context) {
    final String selectedWidgetName = titles[index];
    final String selectedWidgetImage = imagePaths[index];
    final String selectedWidgetNumber = subtitles[index];

    // Arrêter l'audio avant de naviguer
    context.findAncestorStateOfType<_FirstScreenState>()?.stopAudio();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(
          widgetName: selectedWidgetName,
          widgetImage: selectedWidgetImage,
          widgetNumber: selectedWidgetNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        navigateToSecondScreen(context);
      },
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${titles[index]} ${subtitles[index]} ركعات'),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePaths[index],
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 16.0),
                Text(
                  titles[index],
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}