class EnvironmentModel {
  static Map<Environment, String> envToStringMap = {
    Environment.DEV: 'development',
    Environment.PROD: 'production',
    Environment.RELEASE: 'release',
    Environment.TEST: 'test',
  };

  static Map<String, Environment> stringToEnvMap = {
    'development': Environment.DEV,
    'production': Environment.PROD,
    'release': Environment.RELEASE,
    'test': Environment.TEST,
  };

  static envToString(Environment env) => envToStringMap[env];

  static stringToEnv(String str) => stringToEnvMap[str];
}

enum Environment {
  DEV,
  PROD,
  RELEASE,
  TEST,
}
