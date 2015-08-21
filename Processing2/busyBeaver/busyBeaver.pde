int tapeIndex = 0;
IntList tape = new IntList();

void setup() {
  size(100, 100);

  int startingIndexValue = 0;
  tape.append(startingIndexValue);
  handleStateA();
}

int tapeValue() {
  return tape.get(tapeIndex);
}

void writeToTape(int tapeVal) {
  tape.set(tapeIndex, tapeVal);
}

void printStateInfo(char state) {
  print(" "+state + tapeValue());
}

void handleStateA() {
  printStateInfo('A');
  if (tapeValue() == 0) {
    writeToTape(1);
    right();
    handleStateB();
  } else {
    writeToTape(1);
    left();
    handleStateC();
  }
}

void handleStateB() {
  printStateInfo('B');
  if (tapeValue() == 0) {
    writeToTape(1);
    left();
    handleStateA();
  } else {
    writeToTape(1);
    right();
    handleStateB();
  }
}

void handleStateC() {
  printStateInfo('C');
  if (tapeValue() == 0) {
    writeToTape(1);
    left();
    handleStateB();
  } else {
    writeToTape(1);
    right();
    halt();
  }
}

void halt() {
}

void left() {
  if (tapeIndex == 0) {
    //ha! hack to deal with lack of insert command in IntList
    tape.reverse();
    tape.append(0);
    tape.reverse();
  } else {
    --tapeIndex;
  }
}

void right() {
  if (tapeIndex == tape.size() - 1) {
    tape.append(0);
  } 
  ++tapeIndex;
}
