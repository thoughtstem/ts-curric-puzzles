#lang racket

(provide the-racket-basics-game)

(require ts-racket
         2htdp/image
         racket/runtime-path
         "quizzes.rkt")

(define-runtime-path package-path "assets")

(define (file-path file-name)
  (build-path  package-path "the-racket-basics-game" file-name))
  

(define random-question-number (random 0 5))

(define questions (list (cons "Where the Interactions window is located: (a)right side, (b)left side?"      '(a))
                        (cons "Where the Definitions window is located: (a)right side, (b)left side?"        '(b))
                        (cons "What is the shortcut to see your previous commands: (a)CTRL-UP, (b)CTRL-U?" '(a))
                        (cons "How to hide Definitions window: (a)CTRL-I, (b)CTRL-D?"                      '(b))
                        (cons "How to see a mini-map of your code: (a)CTRL-UP, (b)CTRL-U?"                 '(b))
                        (cons "What is the shortcut to run the code in Racket: (a)CTRL-R, (b)CTRL-DOWN?"   '(a))))

;Abstract this...
(define-syntax-rule (try-circle params ...)
  (try (circle params ...)))

; the-racket-basics-game
; Interactions, Definitions windows,run button ,shortcuts CTRL-UP & CTRL-DOWN, CTRL-D, CTRL-R, CTRL-U.

(define qs
  (list
   (yes-no-question (stack
                     "This puzzle will help you to get familiar with Dr. Racket interface!"
                     (row "If no other instructions are given, please always type " (code (yes)))
                     " to proceed to the next question.")
                    'yes)

   (yes-no-question (stack
                     "In Dr. Racket you have a Definitions window on the left side."
                     (bitmap/file (file-path "1-definitions-window.png"))
                     "Can you see your Definitions window?")
                    'yes)
   
   (yes-no-question (stack
                     "In the Definitions window you can type, save, and run your code."
                     "That is the window you will be writing your programs in!")
                    'yes)

   (yes-no-question (stack
                     "Run button used to run code in the Definitions window."
                     (bitmap/file (file-path  "2-run-button.png"))
                     "Can you find the Run button (don't click yet!) in your Racket window?")
                    'yes)

   (yes-no-question (stack
                     "Now please open a new Dr. Racket file and try to type and run "
                     "this code in the Definitions window:"
                     (code (require 2htdp/image))
                     (code (star 50 "solid" "yellow"))
                     "Please try it now and get back to this window.")
                    'yes)

   (yes-no-question (stack
                     "That's right, you got a star!"
                     (bitmap/file (file-path "3-definitions-code.png")))
                    'yes)

   (yes-no-question (stack
                     "Great, there is an Interactions window on the right side."
                     (bitmap/file (file-path "4-interactions-window.png"))
                     "Can you see your Interactions window?")
                    'yes)

   (yes-no-question (stack
                     "In an Interactions window you can type and run commands right away!"
                     "Do you want to try it yourself?")
                    'yes)

   (yes-no-question (stack
                     "Just type this commands and hit Enter key:"
                     (code (require 2htdp/image))
                     (code (star 50 "solid" "blue"))
                     (row "Please answer " (code (yes)) " when you're done."))
                    'yes)

   (yes-no-question (stack
                     "That's right, you just got a blue star!"
                     (bitmap/file (file-path "5-interactions-code.png")))
                    'yes)

   (yes-no-question (stack
                     "Now, do you want to code faster?"
                     "Then you have to know keyboard shortcuts! Ready?")
                    'yes)

   (yes-no-question (stack
                     "Try shortcut CTRL-UP."
                     "Press down and hold the CTRL key with one finger"
                     "then tap the UP key once with another finger."
                     (bitmap/file (file-path "6-keyboard-ctrl-up.png")))
                    'yes)

   (yes-no-question (stack
                     "Great! Shortcut CTRL-UP will show you previously runned command"
                     "in Interactions window."
                     (row "Can you use CTRL-UP until you see very first command " (code (show-me))"?"))
                    'yes)

   (yes-no-question (stack
                     "CTRL-DOWN paired with CTRL-UP helps to navigate"
                     "in your previously used commands."
                     (bitmap/file (file-path "7-keyboard-ctrl-down.png"))
                     "Please make sure you can use both shortcuts. They are super helpful!")
                    'yes)

   (yes-no-question (stack
                     "Next useful shortcut is CTRL+D."
                     "It hides Definitions window. Please try it!"
                     (bitmap/file (file-path "8-keyboard-ctrl-d.png")))
                    'yes)

   (yes-no-question (stack
                     "Use CTRL+D, to have Definitions window back."
                     "Feel free to use it again.")
                    'yes)

   (yes-no-question (stack
                     "Remember the Run button to run your code?"
                     "You can use shortcut CTRL-R instead of clicking the button."
                     (bitmap/file (file-path "9-keyboard-ctrl-r.png"))
                     "Feel free to try it in separate Racket window.")
                    'yes)

   (yes-no-question (stack
                     "Shortcut CTRL+U will show you a mini-map of your code."
                     (bitmap/file (file-path "10-keyboard-ctrl-u.png"))
                     "Please try yo use it, mini-map apperas in the top-right corner"
                     "of the Definitions window.")
                    'yes)

   (yes-no-question (stack
                      "CTRL+U is very helpful when you have a long code,"
                      "you can click on the mini-map and navigate through your program.")
                    'yes)

   (simple-question (stack
                     "To finish this puzzle here is a random question for you:"
                     (car (list-ref questions random-question-number))
                     (row "Please answer as " (code (answer '(a))) " or " (code (answer '(b)))"."))
                    (curry equal? (cdr (list-ref questions random-question-number)))) 
))

(define (the-racket-basics-game)
  (apply start-quiz qs))

(module+ test
  (the-racket-basics-game))
