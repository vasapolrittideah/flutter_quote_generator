import 'package:flutter_quote_generator/data/models/quote_model.dart';

import 'model_factory.dart';

class QuoteModelFactory extends ModelFactory<QuoteModel> {
  @override
  QuoteModel generateFake() {
    return QuoteModel(
      id: createFakeId(),
      author: faker.person.name(),
      quote: faker.lorem.sentence(),
    );
  }

  @override
  List<QuoteModel> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}
