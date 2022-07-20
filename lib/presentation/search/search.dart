import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/apllication/search/search_bloc.dart';
import 'package:netflix/domain/core/debounce/debounce.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    log('SearchPage build');
    context.read<SearchBloc>().add(const Initialized());

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        TextFormField(
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              if (value.isEmpty) {
                return;
              }

              _debouncer.run(() {
                print('searching');
                context.read<SearchBloc>().add(SearchMovie(movieQuery: value));
              });
            }),
        BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state.searchResultList.isEmpty) {
            return IdelWidget();
          } else {
            return const searResultWidget();
          }
        })
      ],
    )));
  }
}

class searResultWidget extends StatelessWidget {
  const searResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        scale: 1,
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                    // 'https://image.tmdb.org/t/p/w500/${state.idelList[index].posterPath}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class IdelWidget extends StatelessWidget {
  IdelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.isLoading) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        ));
      } else if (state.isError) {
        return const Center(
            child: Text(
          'Error',
          // style: TextStyle(color: Colors.red),
        ));
      } else {
        return Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: state.idelList.length,
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
              itemBuilder: (context, index) {
                log(index.toString());
                return Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500/${state.idelList[index].posterPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Center(
                      child: Text('title'),
                    )
                  ],
                );
              }),
        );
      }
    });
  }
}
