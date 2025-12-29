# Local DB (Drift) Setup

Run code generation after model changes:
dart run build_runner build --delete-conflicting-outputs

Hot watch:
dart run build_runner watch --delete-conflicting-outputs

IMPORTANT:
After adding @DataClassName annotations or changing tables run:
dart run build_runner build --delete-conflicting-outputs

If you see errors like 'MemberRow not found' or 'SongRow not found', you have not generated code yet.
