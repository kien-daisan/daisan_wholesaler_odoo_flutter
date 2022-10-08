import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_repository.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
import 'package:flutter_project_structure/screens/product/bloc/review_screen_state.dart';

class ReviewScreenBloc extends Bloc<ProductScreenEvent, ReviewScreenState> {
  ProductScreenRepositoryImp? repository;

  ReviewScreenBloc({this.repository}) : super(ReviewScreenInitial()) {
    on<ProductScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      ProductScreenEvent event, Emitter<ReviewScreenState> emit) async {
    if (event is ReviewsDataFetchEvent) {
      try {
        var model =
            await repository?.getProductReviews(event.productId.toString());
        if (model != null) {
          emit(ReviewScreenSuccess(model));
        } else {
          emit(ReviewScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ReviewScreenError(error.toString()));
      }
    } else if (event is ReviewLikeDislikeEvent) {
      try {
        var model = await repository?.likeDislikeReview(
            event.reviewId.toString(), event.isHelpful??false);
        print('wqqwd--${model?.message}');
        if (model != null) {
          emit(LikeDislikeReviewSuccess(model));
        } else {
          emit(ReviewScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ReviewScreenError(error.toString()));
      }
    }
  }
}
