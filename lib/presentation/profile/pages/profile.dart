import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/app_bar.dart';
import 'package:spotify_clone/common/widgets/favorite_button/favroite_button.dart';
import 'package:spotify_clone/core/constants/app_urls.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backgroundColor: Color(0xff2C2B2B),
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          SizedBox(height: 30),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ProfileInfoCubit()..getUser();
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
          if (state is ProfileInfoLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(state.userEntity.imageURL!),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(state.userEntity.email!),
                const SizedBox(height: 10),
                Text(
                  state.userEntity.fullName!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          }
          if (state is ProfileInfoFailure) {
            return Text('Failed to load profile');
          }
          return Container();
        }),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (BuildContext context) {
        return FavoriteSongsCubit()..getFavoriteSongs();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORITE SONGS'),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SongPlayerPage(
                              songEntity: state.favoriteSongs[index],
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppUrls.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}',
                                    ),
                                  )),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.favoriteSongs[index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  state.favoriteSongs[index].artist,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    color: Color(0xffC6C6C6),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration
                                      .toString()
                                      .replaceAll('.', ':'),
                                ),
                                SizedBox(width: 20),
                                FavroiteButton(
                                    function: () {
                                      context
                                          .read<FavoriteSongsCubit>()
                                          .removeSong(index);
                                    },
                                    key: UniqueKey(),
                                    songEntity: state.favoriteSongs[index]),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return Text('Failed to load favorite songs');
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
