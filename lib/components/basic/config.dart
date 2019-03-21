class Config {
  static Map<String, dynamic> configMap = {
    'api_gateway': 'http://127.0.0.1:9501'
  };

  static dynamic fetch(String keys, {dynamic defaultValue = ''}) {
    List<String> keysArr = keys.split('.');

    dynamic configValue = configMap;

    keysArr.forEach((dynamic v) {
      if (configValue is Map<String, dynamic> && configValue.containsKey(v)) {
        configValue = configValue[v];
      } else {
        configValue = defaultValue;
      }
    });

    return configValue;
  }
}
