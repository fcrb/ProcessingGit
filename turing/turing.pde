/*
Busy Beaver implementation, made more flexible so that we can more easily
 add new symbols, states, and instructions.
 */
int tapeIndex = 0;
TuringState a, b, c, d;
boolean MOVE_RIGHT = true;
boolean MOVE_LEFT = false;
TuringState HALT = new HaltState();
char BLANK_SYMBOL = '0';
char ONE = '1';
String tape;
int stepCounter = 0;

void setup() {
  size(100, 100);

  //initialize the tape
  tape = ""+BLANK_SYMBOL;

  initializeThreeStateBusyBeaver();

  //Run!!
  a.handleState();
  
  println("\nsteps = " + stepCounter);
}

void initializeThreeStateBusyBeaver() {
  a = new TuringState('A');
  b = new TuringState('B');
  c = new TuringState('C');
  a.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_RIGHT, b));
  a.setInstruction(new NoteOfInstruction(ONE, ONE, MOVE_LEFT, c));
  b.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_LEFT, a));
  b.setInstruction(new NoteOfInstruction(ONE, ONE, MOVE_RIGHT, b));
  c.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_LEFT, b));
  c.setInstruction(new NoteOfInstruction(ONE, ONE, MOVE_RIGHT, HALT));
}

void initializeFourStateBusyBeaver() {
  a = new TuringState('A');
  b = new TuringState('B');
  c = new TuringState('C');
  d = new TuringState('D');
  a.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_RIGHT, b));
  a.setInstruction(new NoteOfInstruction(ONE, ONE, MOVE_LEFT, b));

  b.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_LEFT, a));
  b.setInstruction(new NoteOfInstruction(ONE, BLANK_SYMBOL, MOVE_LEFT, c));

  c.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_RIGHT, HALT));
  c.setInstruction(new NoteOfInstruction(ONE, ONE, MOVE_LEFT, d));

  d.setInstruction(new NoteOfInstruction(BLANK_SYMBOL, ONE, MOVE_RIGHT, d));
  d.setInstruction(new NoteOfInstruction(ONE, BLANK_SYMBOL, MOVE_RIGHT, a));
}

class HaltState extends TuringState {
  HaltState() {
    super('H');
  }

  void handleState() {
    printStateInfo('H');
  }
}

class NoteOfInstruction {
  char readSymbol;
  char writeSymbol;
  boolean moveRight;
  TuringState nextState;

  NoteOfInstruction(char _readSymbol, char _writeSymbol, boolean _moveRight, TuringState _nextState) {
    readSymbol = _readSymbol;
    writeSymbol = _writeSymbol;
    moveRight = _moveRight;
    nextState = _nextState;
  }
}


char tapeValue() {
  return tape.charAt(tapeIndex);
}

class TuringState {
  char name;
  ArrayList<NoteOfInstruction> instructions = new ArrayList<NoteOfInstruction>();

  TuringState(char _name) {
    name = _name;
  }

  void setInstruction(NoteOfInstruction instruction) {
    instructions.add(instruction);
  }


  void handleState() {
    printStateInfo(name);
    NoteOfInstruction instructionToExecute = null;
    //find instruction with correct readSymbol
    for (NoteOfInstruction instruction : instructions) {
      if (tapeValue() == instruction.readSymbol) {
        instructionToExecute = instruction;
      }
    }
    //execute the instruction
    writeToTape(instructionToExecute.writeSymbol);
    if (instructionToExecute.moveRight) {  
      right();
    } else { 
      left();
    }
    ++stepCounter;
    instructionToExecute.nextState.handleState();
  }
}

void writeToTape(char tapeVal) {
  char[] chars = tape.toCharArray();
  chars[tapeIndex] = tapeVal;
  tape = new String(chars);
}

void printStateInfo(char state) {
  print(" "+state + tapeValue());
}

void left() {
  if (tapeIndex == 0) {
    tape = BLANK_SYMBOL + tape;
  } else {
    --tapeIndex;
  }
}

void right() {
  if (tapeIndex == tape.length() - 1) {
    tape += BLANK_SYMBOL;
  } 
  ++tapeIndex;
}
