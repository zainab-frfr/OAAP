class ClientCategoryAccess {

  final String client;
  final Map<String,List<String>> categoryAccess;

  ClientCategoryAccess({
    required this.client,
    required this.categoryAccess,
  });

  factory ClientCategoryAccess.fromJson(String clientName, Map<String, dynamic> fetchedData) {
    // clientName: This represents the document ID for the client aka client ka naam 
    // fetchedData: keys are category names, values are a list of people with access  
    
    Map<String, List<String>> categories = {};

    fetchedData.forEach((categoryName, accessList) { //for every category 
      categories[categoryName] = List<String>.from(accessList);
    });

    return ClientCategoryAccess(
      client: clientName,
      categoryAccess: categories,
    );
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.writeln('Client: $client');
    categoryAccess.forEach((category, accessList) {
      sb.writeln('  Category: $category');
      sb.writeln('    Access: ${accessList.join(", ")}');
    });
    return sb.toString();
  }
}

// data returned in this format from firebase: 
/*
Map<String, dynamic> clientsData = {
  "ClientA": {
    "categories": {
      "Category1": {
        "access": {
          "user1@example.com": {},
          "user2@example.com": {}
        }
      },
      "Category2": {
        "access": {
          "user3@example.com": {},
          "user4@example.com": {}
        }
      }
    }
  },
  "ClientB": {
    "categories": {
      "Category1": {
        "access": {
          "user5@example.com": {}
        }
      }
    }
  }
};
*/