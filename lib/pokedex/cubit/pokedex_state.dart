part of 'pokedex_cubit.dart';

enum PokedexStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == PokedexStatus.initial;
  bool get isLoading => this == PokedexStatus.loading;
  bool get isSuccess => this == PokedexStatus.success;
  bool get isFailure => this == PokedexStatus.failure;
}

final class PokedexState extends Equatable {
  PokedexState({
    this.status = PokedexStatus.initial,
    Pokedex? pokedex,
  }) : pokedex = pokedex ?? Pokedex.empty();

  factory PokedexState.fromMap(Map<String, dynamic> map) =>
      PokedexState.fromPick(pick(map).required());

  factory PokedexState.fromPick(RequiredPick pick) => PokedexState(
        status: PokedexStatus.values[pick('status').asIntOrThrow()],
        pokedex: Pokedex.fromPick(pick('pokedex').required()),
      );

  final PokedexStatus status;
  final Pokedex pokedex;

  PokedexState copyWith({
    PokedexStatus? status,
    Pokedex? pokedex,
  }) =>
      PokedexState(
        status: status ?? this.status,
        pokedex: pokedex ?? this.pokedex,
      );

  Map<String, dynamic> toMap() => {
        'status': status.index,
        'pokedex': pokedex.toMap(),
      };

  @override
  List<Object> get props => [
        status,
        pokedex,
      ];
}
