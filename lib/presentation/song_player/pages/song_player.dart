import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/widgets/app_bar.dart';
import 'package:spotify_clone/common/widgets/favorite_button/favroite_button.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/core/constants/app_urls.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        action: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            )),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
              '${AppUrls.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppUrls.mediaAlt}'),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(),
              const SizedBox(height: 30),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppUrls.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppUrls.mediaAlt}'),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xffC6C6C6),
              ),
            ),
          ],
        ),
        FavroiteButton(songEntity: songEntity)
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(
                      context.read<SongPlayerCubit>().songPosition)),
                  Text(formatDuration(
                      context.read<SongPlayerCubit>().songDuration)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow_rounded),
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
