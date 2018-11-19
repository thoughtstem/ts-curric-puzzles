#lang racket

(provide the-shortcuts-game)

(require ts-racket
         2htdp/image
         racket/runtime-path
         "quizzes.rkt")

;Abstract this...
(define-syntax-rule (try-circle params ...)
  (try (circle params ...)))

(define-runtime-path package-path "assets")

(define (file-path file-name)
  (build-path  package-path "the-shortcuts-game" file-name))

(define (show-text)
  "coding Crocodile")

; the-shortcuts-game
; CTRL-C & CTRL-V, CTRL-Z & CTRL-Y, CTRL-S, CTRL-F.
(define qs
  (list
   (yes-no-question (stack
                     "This game will show you some very useful keyboard shortcuts!"
                     (row "If no other instructions are given, please always type " (code (yes)))
                     " to proceed to the next question.")
                    'yes)

   (yes-no-question (stack
                     "Keyboard shortcuts are keys or combinations of keys that provide"
                     "an alternative way to do something that you’d typically do with a mouse."
                     (bitmap/file (file-path "1-keyboard-shortcuts.jpg")))
                    'yes)

   (yes-no-question (stack
                     "Let’s start with copy/paste shortcuts that allow to copy and paste text,"
                     "images and files!")
                    'yes)

   (yes-no-question (stack
                     "CTRL-C used to copy."
                     "Try it: press down and hold the CTRL key with one finger"
                     "then tap the C key once with another finger. It won't do anything yet."
                     (bitmap/file (file-path "2-keyboard-ctrl-c.png"))
                     "Can you find CTRL-C on your keyboard?")
                    'yes)
   
   (yes-no-question (stack
                     "CTRL-V used to paste. Please try to locate keys for this shortcut."
                     (bitmap/file (file-path "3-keyboard-ctrl-v.png")))
                    'yes)

   (simple-question (stack
                     "Now, lets practice copying and pasting text:"
                     (row "1. Type " (code (show-text)) " to get some text.")
                     "2. Click and drag your mouse to select and CTRL-C to copy the longest word."
                     (row "3. Paste using CTRL-V inside " (code (answer '____)) " form, so it looks like:")
                     (row (code (answer 'pasted-word)) ".")
                     "4. Hit Enter key.")
                    (curry equal? 'Crocodile))

   (simple-question (stack
                     "Great, let’s practice more:"
                     (row "use " (code (show-text)) " to see the text and copy CTRL-C and paste CTRL-V")
                     (row "the shortest word from the text into " (code (answer '___)) "."))
                    (curry equal? 'coding))

   (yes-no-question (stack
                     "Great job! Next useful shortcut is CTRL-S,"
                     "this will save the file you’re working with."
                     (bitmap/file (file-path "4-keyboard-ctrl-s.png"))
                     "Can you find CTRL-S keys on your keyboard?")
                    'yes)

   (yes-no-question (stack
                     "Next two very useful shortcuts are undo and redo changes." 
                     "For example, they will help you to return accidently deleted code!"
                     "Isn't that neat?")
                    'yes)

   (yes-no-question (stack
                     "CTRL-Z will reverse (undo) changes you just made."
                     (bitmap/file (file-path "5-keyboard-ctrl-z.png"))
                     "Can you find CTRL-Z keys on your keyboard?")
                    'yes)

   (simple-question (stack
                     "Please try to use CTRL-Z yourself:"
                     "1. in Interactions window type (answer ‘laptop))))"
                     "2. use CTRL-Z three times."
                     "3. hit Enter key.")
                    (curry equal? 'laptop))
   
   (yes-no-question (stack
                     "Next, when you just reversed some changes with CTRL-Z"
                     "and want to have them back, use CTRL-Y."
                     (bitmap/file (file-path "6-keyboard-ctrl-y.png"))
                     "Please locate CTRL-Y on your keyboard.")
                    'yes)

   (simple-question (stack
                     "Now, please try to use both CTRL-Z to undo and CTRL-Y to redo:"
                     "1. in Interactions window type (answer ‘bagel))))"
                     "2. use CTRL-Z to undo four times"
                     "3. use CTRL-Y once to redo"
                     "4. hit Enter key.")
                    (curry equal? 'bagel))

   (yes-no-question (stack
                     "Great! The very last useful shortcut is CTRL-F that"
                     "helps to search for words in the code or text and files."
                     (bitmap/file (file-path "7-keyboard-ctrl-f.png"))
                     "Make sure you can find CTRL-F combo on your keyboard.")
                    'yes)

   (yes-no-question (stack
                     "Please try to use CTRL-F to find the word bagel in Interactions window:"
                     "1. press CTRL-F, search text field will pop up"
                     (row "2. type in the word " (code bagel))
                     "3. hit Enter key"
                     "You may need to scroll a little to see a circled word bagel."
                     "Can you see how CTRL-F works?")
                    'yes)

   (yes-no-question (stack
                     "Fantastic!"
                     "It was a lot of shortcuts but with practice"
                     "you will remember all of them quickly!")
                    'yes) 
))

(define (the-shortcuts-game)
  (apply start-quiz qs))

(module+ test
  (the-shortcuts-game))
