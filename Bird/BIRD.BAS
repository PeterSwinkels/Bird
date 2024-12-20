DEFINT A-Z
DECLARE SUB DrawBird (x, y, BirdFrame)
DECLARE SUB Drawlandscape ()
DECLARE SUB Initialize ()
DECLARE SUB Intro ()
DECLARE SUB LoadBird ()
DECLARE SUB LoadLandscape ()
DECLARE SUB Main ()
DECLARE SUB Quit ()
DECLARE SUB ScrollBackground (Direction)

DIM SHARED Bird(0 TO 31)
DIM SHARED BirdBackground(0 TO 7)
DIM SHARED BirdFrame
DIM SHARED Landscape(0 TO 16001)

Initialize
Intro
CALL Main

FlapWings:
 PLAY "N0"

 IF BirdFrame = 16 THEN
  BirdFrame = 0
 ELSE
  BirdFrame = BirdFrame + 16
 END IF
RETURN

SUB DrawBird (x, y, BirdFrame)
 GET (x, y)-STEP(2, 2), BirdBackground(0)
 PUT (x, y), Bird(BirdFrame + 8), AND
 PUT (x, y), Bird(BirdFrame), XOR
 PCOPY 1, 0
 PUT (x, y), BirdBackground(0), PSET
END SUB

SUB Initialize
 SCREEN 7, , 1, 0
 CLS

 LoadLandscape
 LoadBird

 BirdFrame = 0

 ON PLAY(1) GOSUB FlapWings
 PLAY ON
 PLAY "MB MS N0"
END SUB

SUB Intro
 COLOR 15

 PRINT "Bird v1.01 - by: Peter Swinkels, 2024"
 PRINT
 PRINT "In this sprite demo the user controls"
 PRINT "a bird flying across a landscape."
 PRINT
 PRINT "- Use the arrow keys to move the bird."
 PRINT "- Press the Escape key to quit."
 PRINT
 PRINT "Press any key to start."
 PCOPY 1, 0

 DO
 LOOP WHILE INKEY$ = ""
END SUB

SUB LoadBird
 DEF SEG = VARSEG(Bird(0))
 BLOAD "Bird.dat", VARPTR(Bird(0))
END SUB

SUB LoadLandscape
 DEF SEG = VARSEG(Landscape(0))
 BLOAD "Landscap.dat", VARPTR(Landscape(0))
END SUB

SUB Main
 BirdX = 160
 BirdY = 100

 PUT (0, 0), Landscape(0), PSET

 DO
  DrawBird BirdX, BirdY, BirdFrame
  Key$ = INKEY$
  SELECT CASE Key$
   CASE CHR$(0) + "H"
    IF BirdY > 0 THEN BirdY = BirdY - 1
   CASE CHR$(0) + "P"
    IF BirdY < 197 THEN BirdY = BirdY + 1
   CASE CHR$(0) + "K"
    IF BirdX <= 80 THEN
     ScrollBackground -1
    ELSE
     BirdX = BirdX - 1
    END IF
   CASE CHR$(0) + "M"
    IF BirdX >= 240 THEN
     ScrollBackground 1
    ELSE
     BirdX = BirdX + 1
    END IF
   CASE CHR$(27)
    Quit
  END SELECT
 LOOP
END SUB

SUB Quit
 PLAY STOP
 SYSTEM
END SUB

SUB ScrollBackground (Direction)
DIM Background(0 TO 12800)
DIM Edge(0 TO 175)

 SELECT CASE Direction
  CASE -1
   GET (319, 70)-(319, 150), Edge
   GET (0, 70)-(318, 150), Background
   PUT (1, 70), Background, PSET
   PUT (0, 70), Edge, PSET
  CASE 1
   GET (0, 70)-(0, 150), Edge
   GET (1, 70)-(319, 150), Background
   PUT (0, 70), Background, PSET
   PUT (319, 70), Edge, PSET
 END SELECT
END SUB

