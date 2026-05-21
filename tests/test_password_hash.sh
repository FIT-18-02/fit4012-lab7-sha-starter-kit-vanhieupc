#!/usr/bin/env bash
set -euo pipefail

# 1. Build project
make password_hash >/dev/null

HASH_FILE="test_password.hash"

# 2. Dọn dẹp file cũ trước khi test
rm -f "$HASH_FILE"

# 3. Đăng ký password
./password_hash register "student-password-123" "$HASH_FILE" >/dev/null

# 4. Kiểm tra file được tạo
if [[ ! -s "$HASH_FILE" ]]; then
  echo "[FAIL] Password hash file was not created"
  exit 1
fi

# 5. Kiểm tra đăng nhập với mật khẩu đúng
if ! ./password_hash login "student-password-123" "$HASH_FILE" >/dev/null; then
  echo "[FAIL] Correct password should login successfully"
  exit 1
fi

# 6. Kiểm tra đăng nhập với mật khẩu sai
if ./password_hash login "wrong password" "$HASH_FILE" >/dev/null; then
  echo "[FAIL] Wrong password should be rejected"
  exit 1
fi

# 7. Dọn dẹp sau khi test xong
rm -f "$HASH_FILE"

echo "[PASS] Password hash and wrong password negative test passed."
exit 0
