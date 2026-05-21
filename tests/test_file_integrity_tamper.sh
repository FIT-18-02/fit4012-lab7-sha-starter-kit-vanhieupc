#!/usr/bin/env bash
# Sử dụng set -euo pipefail để đảm bảo tính an toàn cho script
set -euo pipefail

# 1. Build project
make sha256 file_integrity >/dev/null

# 2. Tạo file tạm an toàn bằng mktemp
TMP_FILE=$(mktemp)
# Tự động xóa file tạm khi script kết thúc
trap 'rm -f "$TMP_FILE"' EXIT

# 3. Ghi dữ liệu ban đầu
printf "FIT4012 file integrity test\n" > "$TMP_FILE"
EXPECTED_HASH=$(./sha256 --hash-file "$TMP_FILE")

# 4. Kiểm tra toàn vẹn trước khi sửa (nên PASS)
if ! ./file_integrity "$TMP_FILE" "$EXPECTED_HASH" >/dev/null; then
  echo "[FAIL] File integrity check should pass before tamper"
  exit 1
fi

# 5. Sửa đổi file để gây ra lỗi (tamper)
printf "tamper" >> "$TMP_FILE"

# 6. Kiểm tra lại tính toàn vẹn sau khi sửa (nên FAIL)
# Nếu lệnh trả về 0 (thành công) nghĩa là lỗi, vì ta mong đợi nó phải phát hiện ra sự thay đổi
if ./file_integrity "$TMP_FILE" "$EXPECTED_HASH" >/dev/null; then
  echo "[FAIL] Tamper test should fail after file is changed"
  exit 1
fi

# 7. Thông báo thành công
echo "[PASS] Tamper / flip 1 byte negative test passed."
exit 0
