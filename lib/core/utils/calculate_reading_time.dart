int calculateReadingTime(String content) {
 final wordCont =  content.split(RegExp(r'\s+')).length;
 final readingTime = wordCont / 225;
  return readingTime.ceil();
}