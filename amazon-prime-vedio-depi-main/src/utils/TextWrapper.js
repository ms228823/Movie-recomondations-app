export function TextWrapper(text) {
  if (text.length < 150) return text;
  const WrappedText = text.slice(0, 150);
  return `${WrappedText}....`;
}
