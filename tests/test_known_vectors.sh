#!/usr/bin/env bash
# Sử dụng set -euo pipefail để dừng script ngay khi có lệnh lỗi
set -euo pipefail

# 1. Build project
make sha256 >/dev/null

# 2. Định nghĩa các giá trị mong đợi
EMPTY_EXPECTED="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
ABC_EXPECTED="ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

# 3. Lấy giá trị thực tế từ chương trình
EMPTY_ACTUAL=$(./sha256 --hash-string "")
ABC_ACTUAL=$(./sha256 --hash-string "abc")

# 4. Kiểm tra đối chiếu với thông báo lỗi cụ thể
if [[ "$EMPTY_ACTUAL" != "$EMPTY_EXPECTED" ]]; then
  echo "[FAIL] Empty string vector mismatch"
  echo "expected: $EMPTY_EXPECTED"
  echo "actual  : $EMPTY_ACTUAL"
  exit 1
fi

if [[ "$ABC_ACTUAL" != "$ABC_EXPECTED" ]]; then
  echo "[FAIL] abc vector mismatch"
  echo "expected: $ABC_EXPECTED"
  echo "actual  : $ABC_ACTUAL"
  exit 1
fi

# 5. Kiểm tra tính năng self-test
if ! ./sha256 --self-test >/dev/null; then
  echo "[FAIL] SHA-256 self-test failed"
  exit 1
fi

# 6. Thông báo thành công
echo "[PASS] SHA-256 known answer tests passed."
exit 0
