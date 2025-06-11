import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int _lastPage = 1;
  final List<UserDataEntity> _items = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_currentPage < _lastPage) {
          _currentPage++;
          context.read<UserListCubit>().fetchUserList(
                GetUserListParams(page: _currentPage),
              );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: CustomAppBar(
        title: "User List",
        actions: [
          IconButton(
            splashColor: Palette.primary500,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.size12),
              ),
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const CustomLogoutDialog(),
            ),
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
              size: Dimens.size20,
            ),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimens.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearch(
              onSearch: (value) {
                _currentPage = 1;
                _items.clear();
                context.read<UserListCubit>().fetchUserList(
                      GetUserListParams(search: value),
                    );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                backgroundColor:
                    Theme.of(context).extension<CustomColor>()!.background,
                onRefresh: () async {
                  _items.clear();
                  _currentPage = 1;
                  await context.read<UserListCubit>().fetchUserList(
                        const GetUserListParams(),
                      );
                },
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<UserListCubit, UserListState>(
                      listener: (_, state) => switch (state) {
                        UserListStateFailure(:final type, :final message) =>
                          (() {
                            if (type is UnauthorizedFailure) {
                              Strings.of(context)!
                                  .expiredToken
                                  .toToastError(context);
                              context.goNamed(Routes.login.name);
                            } else {
                              message.toToastError(context);
                            }
                          })(),
                        _ => {},
                      },
                    ),
                  ],
                  child: BlocBuilder<UserListCubit, UserListState>(
                    builder: (context, state) {
                      switch (state) {
                        case UserListStateLoading():
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case UserListStateSuccess(:final data):
                          if (data?.data?.data == null ||
                              data!.data!.data!.isEmpty) {
                            return const Center(child: Empty());
                          }
                          if (_currentPage == 1) _items.clear();
                          _items.addAll(data.data?.data ?? []);
                          _lastPage = data.data?.lastPage ?? 1;
                          return Column(
                            children: [
                              Expanded(
                                child: UserListSection(
                                  scrollController: _scrollController,
                                  currentPage: _currentPage,
                                  lastPage: _lastPage,
                                  items: _items,
                                  isLastPage: _currentPage == _lastPage,
                                ),
                              ),
                            ],
                          );
                        case UserListStateFailure(:final message):
                          return Center(
                            child: Empty(
                              errorMessage: message,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    fontSize: Dimens.text14,
                                    fontWeight: FontWeight.w400,
                                  ),
                              buttonColor: Theme.of(context)
                                  .extension<CustomColor>()!
                                  .card,
                              buttonTitleColor: Palette.black,
                              onRetry: () {
                                context.read<UserListCubit>().fetchUserList(
                                      GetUserListParams(
                                        page: _currentPage,
                                      ),
                                    );
                              },
                            ),
                          );
                        case UserListStateEmpty():
                          return const Center(child: Empty());
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
