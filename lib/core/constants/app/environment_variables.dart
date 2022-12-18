
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// environment variable values are taken from the environment and defined as static values within [EnvironmentVariables].
class EnvironmentVariables{
  static  String awsS3RouteUrl = dotenv.env["main_aws_s3_route"] ?? "";
  static String apiMainRoute = dotenv.env["main_route"] ?? "";
}