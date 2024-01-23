import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/utils/utils.dart';

void main() {
  group('Test splice list', () {
    test('Test list is not empty', () {
      List<int> list = [1, 2, 3, 4];
      expect(Utils.splice(list, 1), [
        [1],
        [2],
        [3],
        [4]
      ]);
      expect(Utils.splice(list, 2), [
        [1, 2],
        [3, 4]
      ]);
      expect(Utils.splice(list, 3), [
        [1, 2, 3],
        [4]
      ]);
      expect(Utils.splice(list, 4), [
        [1, 2, 3, 4]
      ]);
      expect(Utils.splice(list, 5), [
        [1, 2, 3, 4]
      ]);
    });
    test('Test list is empty', () {
      expect(Utils.splice([], 3), []);
    });
  });

  group('Test toggleList ', () {
    test('Test list with not existing value', () {
      List<int> inputIntList = [1, 2, 3, 4, 5];
      expect(Utils.toggleList(inputIntList, 6), [1, 2, 3, 4, 5, 6]);

      List<String> inputStringList = ['apple', 'banana', 'orange'];
      expect(Utils.toggleList(inputStringList, 'grape'),
          ['apple', 'banana', 'orange', 'grape']);

      List<MUser> inputMUserList = [
        MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
        MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
        MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
      ];
      expect(
        Utils.toggleList(
          inputMUserList,
          MUser(id: 'abc4', name: 'keith', email: 'keith_vo@gmail.com'),
        ),
        [
          MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
          MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
          MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
          MUser(id: 'abc4', name: 'keith', email: 'keith_vo@gmail.com')
        ],
      );

      expect(
        Utils.toggleList(
          inputMUserList,
          MUser(id: 'abc4', name: 'keith', email: 'keith@gmail.com'),
        ),
        [
          MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
          MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
          MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
          MUser(id: 'abc4', name: 'keith', email: 'keith@gmail.com')
        ],
      );
    });
    test('Test list  with existing value', () {
      List<int> inputIntList = [1, 2, 3, 4, 5];
      expect(Utils.toggleList(inputIntList, 3), [1, 2, 4, 5]);

      List<String> inputStringList = ['apple', 'banana', 'orange'];
      expect(Utils.toggleList(inputStringList, 'apple'), ['banana', 'orange']);

      List<MUser> inputMUserList = [
        MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
        MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
        MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
      ];
      expect(
        Utils.toggleList(
          inputMUserList,
          MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
        ),
        [
          MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
          MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
        ],
      );
    });
  });

  group('Test isNullOrEmpty ', () {
    test('Test null value', () {
      Object? inputObject;
      expect(isNullOrEmpty(inputObject), true);
      String? inputString;
      expect(isNullOrEmpty(inputString), true);
      List<int>? inputList;
      expect(isNullOrEmpty(inputList), true);
    });
    test('Test with string value', () {
      String? inputEmpty = '';
      expect(isNullOrEmpty(inputEmpty), true);

      String? inputString = 'Join Us';
      expect(isNullOrEmpty(inputString), false);
    });
    test('Test with list value', () {
      List<int>? inputEmpty = [];
      expect(isNullOrEmpty(inputEmpty), true);

      List<MUser>? input = [
        MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
        MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
        MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
      ];
      expect(isNullOrEmpty(input), false);
    });

    test('Test with map value', () {
      Map<String, int>? inputEmpty = {};
      expect(isNullOrEmpty(inputEmpty), true);

      Map<String, dynamic>? input =
          MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com').toMap();
      expect(isNullOrEmpty(input), false);
    });
  });

  group('Test listOf ', () {
    test('Test get list name user', () {
      List<MUser> inputMUserList = [
        MUser(id: "abc1", name: 'keith', email: 'keith@gmail.com'),
        MUser(id: "abc2", name: 'Goal', email: 'CR7@gmail.com'),
        MUser(id: "abc33", name: 'Lion', email: 'Lion@gmail.com'),
      ];

      String toElement(e) => e.name;
      expect(
          Utils().listOf(inputMUserList, toElement), ['keith', 'Goal', 'Lion']);
    });

    test('Test get input map null', () {
      List<MUser>? inputMUserList;

      String toElement(e) => e.email;
      expect(Utils().listOf(inputMUserList, toElement), []);
    });
  });

  group('Test fullNameOf ', () {
    test('Test null value', () {
      expect(Utils.fullNameOf('Keith', null), 'Keith');
      expect(Utils.fullNameOf(null, 'Vo'), 'Vo');
      expect(Utils.fullNameOf(null, null), '');
    });

    test('Test string value', () {
      expect(Utils.fullNameOf('Keith', 'Vo'), 'Keith Vo');
      expect(Utils.fullNameOf('Keith', 'Vo', separated: '-'), 'Keith-Vo');
      expect(Utils.fullNameOf('Keith', 'Vo', separated: '&'), 'Keith&Vo');
    });
  });
}
