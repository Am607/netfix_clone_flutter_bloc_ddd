import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/apllication/fast_laugh/fast_laugh_bloc.dart';

class FastLuaghPage extends StatelessWidget {
  const FastLuaghPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context)
          .add(const FastLaughEvent.intilal());
    });
    return Scaffold(
      body: SafeArea(
        child: PageView(
            scrollDirection: Axis.vertical,
            children: List.generate(10, (index) {
              return BlocBuilder<FastLaughBloc, FastLaughState>(
                builder: (context, state) {
                  if (state.isError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  } else if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.videoList.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  } else {
                    return VideoItem(
                      index: index,
                    );
                  }
                },
              );
            })),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final int index;
  VideoItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red[index * 100],
          child: Center(
            child: Text('$index'),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/200/300?image=${index + 1}'),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.play_arrow)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              ],
            )),
        Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.audiotrack_rounded),
                )
              ],
            ))
      ],
    );
  }
}
