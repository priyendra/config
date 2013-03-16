function from_hrbytes(num) {
  if (match(num, /^.*G$/) != 0) {
    sub(/G$/, "", num);
    num = num * 1024 * 1024 * 1024;
  } else if (match(num, /^.*M$/) != 0) {
    sub(/M$/, "", num);
    num = num * 1024 * 1024;
  } else if (match(num, /^.*K$/) != 0) {
    sub(/K$/, "", num);
    num = num * 1024;
  } else if (match(num, /^.*B$/) != 0) {
    sub(/B$/, "", num);
  }
  return num
}

function to_hrbytes(num) {
  if (num < 1024) {
    return sprintf("%0.4fB", num);
  } else if (num < 1024*1024) {
    return sprintf("%0.4fK", num/1024.0);
  } else if (num < 1024*1024*1024) {
    return sprintf("%0.4fM", num/(1024.0*1024));
  } else {
    return sprintf("%0.4fG", num/(1024.0*1024*1024));
  }
}
