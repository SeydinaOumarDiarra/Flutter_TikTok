import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TikTok',
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}


/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          const BottomNavigationBarItem(
            icon: Icon(MdiIcons.compassOutline),
            label: 'Découvrir',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/tiktok_add.png", height: 25,),
           label: '',
         ),
           const BottomNavigationBarItem(
            icon: Icon(Icons.comment_outlined),
            label: 'Boite de réception',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF141518),
        //Definir la couleur d'un icon lorsque il est cliquer
        selectedItemColor: Colors.white,
        //Definir la couleur d'un icon par defaut
        unselectedItemColor: Colors.grey,
        //Pour enlever le nom des icons
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}


class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final List<Map> tiktokItems = [
    {
      "video": "assets/videos/video_1.mp4"
    },
    {
      "video": "assets/videos/video_2.mp4"
    },
    {
      "video": "assets/videos/video_3.mp4"
    },
    {
      "video": "assets/videos/video_4.mp4"
    },
    {
      "video": "assets/videos/video_5.mp4"
    },
    {
      "video": "assets/videos/video_6.mp4"
    },

  ];
  @override
  Widget build(BuildContext context) {
    //création de carousel
    return CarouselSlider(
  options: CarouselOptions(
    // Definir le carousel en plein ecran (prendre toute l'ecran)
    height: double.infinity,
    //Definir le caroussel en vertical
    scrollDirection: Axis.vertical,
    // Definir la taille des carousels sur tout l'écran
    viewportFraction: 1.0,
    ),
  items: tiktokItems.map((item) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: const Color(0xFF141518),
          //Definir en enfant des widgets superposés
          child: Stack(
              children: [
                VideoWidget(videoUrl: item['video']),
                const PostContent()
              ],
          )
        );
      },
    );
  }).toList(),
);
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState(this.videoUrl);
}

class _VideoWidgetState extends State<VideoWidget> {

  // Appel du controller permettant de jouer un video
  late VideoPlayerController _controller;
  final String videoUrl;
  _VideoWidgetState(this.videoUrl);

  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        _controller.setLooping(true);

        // Lire la vidéo
        _controller.play();
        setState(() {});
      });
  }


  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}

class PostContent extends StatelessWidget {
  const PostContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container d'entête
       Container(
        height: 100,
        padding: const EdgeInsets.only(top: 40),
        //color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
                  Icons.tv_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              SizedBox(width: 50,),
             Text('Abonnements', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w700),),
             SizedBox(width: 20,),
             Text('Pour toi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
             SizedBox(width: 50,),
             Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
          ],
        ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                // Container Body
                child: Container(
                  //color: Colors.red.withOpacity(0.5),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '@seybar_0112',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          )
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'TP sur flutter en interprettant TikTok. #ODC #ODK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          )
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Son Original - Iba_One',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  )
                  ),

              // Container SideBar
              SizedBox(
                width: 80, 
               // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 80, 
                      //color: Colors.blue
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                           Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const CircleAvatar(
                            radius: 25,
                            backgroundImage: 
                                AssetImage('assets/images/photo-5.jpeg'),
                           ),
                          ),
                           Container(
                             padding: const EdgeInsets.all(2),
                             decoration: BoxDecoration(
                               color: Colors.red,
                               borderRadius: BorderRadius.circular(20)
                             ),
                             child: const Icon(
                               Icons.add,
                               color: Colors.white,
                               size: 15,
                             )
                           )
                        ],
                      ),
                      ),


                    SizedBox(
                      height: 80, 
                      //color: Colors.teal
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite, 
                            color: Colors.white.withOpacity(0.85),
                            size: 45,
                          ),
                          const Text(
                            '30.1K',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      ),


                    SizedBox(
                      height: 80, 
                      //color: Colors.yellow
                      child: Column(
                        children: [
                          Icon(
                            Icons.comment_outlined, 
                            color: Colors.white.withOpacity(0.85),
                            size: 45,
                          ),
                          const Text(
                            '500',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      ),


                    SizedBox(
                      height: 80, 
                      //color: Colors.orange
                      child: Column(
                        children: [
                          Icon(
                            MdiIcons.share, 
                            color: Colors.white.withOpacity(0.85),
                            size: 45,
                          ),
                          const Text(
                            '120',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),



                   const AnimatedLogo(),
                  ],
                  ),
                )
          ],),
          )
    ],
    );
  }
}


//Animation de Logo Audio TikTok
class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> 
      with SingleTickerProviderStateMixin
{
  late AnimationController _controller;

  @override
  void initState(){
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller, 
      builder: (_, child){
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
          );
      },

      child: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: const DecorationImage(
            image: AssetImage("assets/images/disc_icon.png"),
          ),
        ),

        child: Image.asset('assets/images/tiktok_icon.png'),
      ),
      );
  }
}


