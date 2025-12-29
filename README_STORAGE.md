# Local JSON Storage Setup

Run code generation after model changes:
dart run build_runner build --delete-conflicting-outputs

Hot watch:
dart run build_runner watch --delete-conflicting-outputs

IMPORTANT:
After changing model serialization, run:
dart run build_runner build --delete-conflicting-outputs

If you see errors related to missing generated serializers, you have not generated code yet.
