DEFINT A-Z
DECLARE SUB Drawlandscape ()
DECLARE SUB DrawBird (x, y, Offset)
DECLARE SUB Initialize ()
DECLARE SUB Intro ()
DECLARE SUB LoadBird ()
DECLARE SUB LoadLandscape ()
DECLARE SUB Main ()
DECLARE SUB Quit ()

DIM SHARED Background(0 TO 7)
DIM SHARED Bird(0 TO 31)
DIM SHARED Landscape(0 TO 16001)
DIM SHARED Offset

Initialize
Intro
CALL Main

Flap:
 PLAY "N0"

 IF Offset = 0 THEN
  Offset = 16
 ELSE
  Offset = 0
 END IF
RETURN

SUB DrawBird (x, y, Offset)
 GET (x, y)-STEP(2, 2), Background(0)
 PUT (x, y), Bird(Offset + 8), AND
 PUT (x, y), Bird(Offset + 0), XOR
 PCOPY 1, 0
 PUT (x, y), Background(0), PSET
END SUB

SUB Initialize
 SCREEN 7, , 1, 0
 CLS

 LoadLandscape
 LoadBird

 ON PLAY(1) GOSUB Flap
 PLAY ON
 PLAY "MB MS N0"
END SUB

SUB Intro
 COLOR 15

 PRINT "Bird v1.00 - by: Peter Swinkels, 2024"
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
 Offset = 0

 PUT (0, 0), Landscape(0), PSET

 DO
  DrawBird BirdX, BirdY, Offset
  Key$ = INKEY$
  SELECT CASE Key$
   CASE CHR$(0) + "H"
    IF BirdY > 0 THEN BirdY = BirdY - 1
   CASE CHR$(0) + "P"
    IF BirdY < 196 THEN BirdY = BirdY + 1
   CASE CHR$(0) + "K"
    IF BirdX > 0 THEN BirdX = BirdX - 1
   CASE CHR$(0) + "M"
    IF BirdX < 316 THEN BirdX = BirdX + 1
   CASE CHR$(27)
    Quit
  END SELECT
 LOOP
END SUB

SUB Quit
 PLAY STOP
 SYSTEM
END SUB

