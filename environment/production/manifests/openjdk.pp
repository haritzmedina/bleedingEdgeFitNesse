# Install OpenJDK
class openjdk {

  package {
    'openjdk-7-jdk':
      ensure  => latest,
  }

}
