import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final List<String> imageUrls = [
    'https://b2296736.smushcdn.com/2296736/wp-content/uploads/2023/01/barbie-birthday-party-ideas.jpg?lossy=0&strip=1&webp=1',
    'https://static.wixstatic.com/media/3f6f49_04ef09d643cd4bf69f6c7a6ec63b1159~mv2.jpg/v1/fill/w_2500,h_1875,al_c/3f6f49_04ef09d643cd4bf69f6c7a6ec63b1159~mv2.jpg',
    'https://media.licdn.com/dms/image/C4D12AQH8uRS4mO9Skg/article-cover_image-shrink_720_1280/0/1520097797413?e=2147483647&v=beta&t=gswjBqGA7vkK8PGVDGrQ7bDfwnx6Ou8lCJ7moPGSkPQ',
    'https://floralife.com/wp-content/uploads/2022/05/Floral-Management_Outdoor-event-1020X600.png',
    'https://cdn.create.vista.com/api/media/small/181254116/stock-photo-dance-party-with-group-people-dancing-and-disco-ball',
    'https://images.squarespace-cdn.com/content/v1/60da576b8b440e12699c9263/1695285926380-82KE652IQ2VN777UAPC1/DSC03272-min+%282%29.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        title: const Text('Image Gallery'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewPage(
                      imageUrl: imageUrls[index],
                      tag: 'image$index',
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'image$index',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImagePreviewPage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const ImagePreviewPage({
    required this.imageUrl,
    required this.tag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
