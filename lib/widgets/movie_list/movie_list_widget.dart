
import 'package:flutter/material.dart';
import '../../resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie ({
    required this.id,
    required this.imageName, 
    required this.title, 
    required this.time, 
    required this.description,
    });
}

class MovieListWidget extends StatefulWidget {

   const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movie = [
    Movie(
      imageName: AppImages.moviePlaceholder, 
      title: 'Mortal Combat', 
      time: '7 апреля 2021', 
      description: 'Боец смешанных единоборств Коул Янг не раз соглашался проиграть за деньги', id: 1),
    Movie(
      imageName: AppImages.moviePlaceholder, 
      title: 'Назад в будущее 1', 
      time: '7 апреля 2021', 
      description: 'Боец смешанных единоборств Коул Янг не раз соглашался проиграть за деньги', id: 2),
    Movie(
      imageName: AppImages.moviePlaceholder, 
      title: 'Назад в будущее 2', 
      time: '7 апреля 2021', 
      description: 'Боец смешанных единоборств Коул Янг не раз соглашался проиграть за деньги', id: 3),
    Movie(
      imageName: AppImages.moviePlaceholder, 
      title: 'Человек-паук', 
      time: '7 апреля 2021', 
      description: 'Боец смешанных единоборств Коул Янг не раз соглашался проиграть за деньги', id: 4),
    Movie(
      imageName: AppImages.moviePlaceholder, 
      title: 'Кобра кай', 
      time: '7 апреля 2021', 
      description: 'Боец смешанных единоборств Коул Янг не раз соглашался проиграть за деньги', id: 5)
  ];

  var _filteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies () {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movie.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movie;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movie;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movie[index].id;
    Navigator.of(context).pushNamed(
      'main_screen/movie_details',
      arguments: id
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(top: 70),
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: ((BuildContext context, index) {
            final movie = _filteredMovies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2)
                    )]
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    children: [
                       Image(image: AssetImage(movie.imageName)),
                       const SizedBox(width: 10,),
                       Expanded(
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                            const SizedBox(height: 7,),
                            Text(
                               movie.time,
                              style: const TextStyle(color: Colors.grey),
                              ),
                            const SizedBox(height: 20,),
                            Text(
                              movie.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              ),
                       
                          ],
                         ),
                       ),
                       const SizedBox(width: 10,)
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _onMovieTap(index),
                  ),
                )
              ],
            ),
          );
        })),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
        )
      ],
    );
  }
}