#!/usr/bin/env bash
set -euo pipefail

# 1. Build project trước
make salted_password_hash >/dev/null

HASH_FILE_1="test_password_salted_1.hash"
HASH_FILE_2="test_password_salted_2.hash"

# 2. Dọn dẹp file cũ nếu có
rm -f "$HASH_FILE_1" "$HASH_FILE_2"

# 3. Đăng ký password
./salted_password_hash register "same-password" "$HASH_FILE_1" >/dev/null
./salted_password_hash register "same-password" "$HASH_FILE_2" >/dev/null

# 4. Kiểm tra file được tạo thành công
if [[ ! -s "$HASH_FILE_1" || ! -s "$HASH_FILE_2" ]]; then
  echo "[FAIL] Salted password hash files were not created"
  exit 1
fi

# 5. Kiểm tra salt: mật khẩu giống nhau phải có hash khác nhau
if cmp -s "$HASH_FILE_1" "$HASH_FILE_2"; then
  echo "[FAIL] Same password should not produce the same salted hash record"
  exit 1
fi

# 6. Kiểm tra đăng nhập với password đúng
if ! ./salted_password_hash login "same-password" "$HASH_FILE_1" >/dev/null; then
  echo "[FAIL] Correct password should login successfully with saved salt"
  exit 1
fi

# 7. Kiểm tra đăng nhập với password sai
if ./salted_password_hash login "wrong password" "$HASH_FILE_1" >/dev/null; then
  echo "[FAIL] Wrong password should be rejected in salted login"
  exit 1
fi

# 8. Clean up sau khi test xong
rm -f "$HASH_FILE_1" "$HASH_FILE_2"

echo "[PASS] Salted password test passed."
exit 0
