#lang racket

(provide sum-sub-game-1
         (rename-out (try-circle circle)))

(require ts-racket
         2htdp/image
         "quizzes.rkt")

;Abstract this...
(define-syntax-rule (try-circle params ...)
  (try (circle params ...)))

; sum-sub-game-1
; Addition and subtraction.

(define qs
  (list
   (yes-no-question (stack
                     "Let’s practice adding and subtracting numbers in Dr. Racket!"
                     "But first, let me show you how to type your answer in this game."
                     (row "Please type " (code (yes)) " to proceed.")) 'yes)

   (yes-no-question (stack
                     "In this game sometimes you will need"
                     (row "to type your answer as " (code (yes)) " or " (code (no))".")
                     (row "Please answer " (code (no)) " to continue.")) 'no)

   (simple-question (stack
                     "For some questions you'll need to type in Dr. Racket command: "
                     (row (code (answer _____))", where the blank field is the command.")
                     "Let's practice that!" 
                     "Please answer this question by typing the command to draw a circle:"
                     (code (answer (circle 20 "solid" "blue"))))
                    (curry equal? (circle 20 "solid" "blue")))

   (simple-question (stack
                     "Great job! Let's play with some numbers!"
                     "I’m sure you know how to add two numbers together."
                     "What is 2 + 3 equal to?"
                     (row "Please use " (code (answer _____)) "."))
                    (curry equal? 5))

   (yes-no-question (stack
                     "That's right!"
                     "To do 2 + 3 in Dr.Racket we need to run following command:"
                     (code (+ 2 3))
                     (row "Please type " (code (yes)) " to proceed."))
                    'yes)
   
   (simple-question (stack
                     "Now, what will be the command to add numbers 1 and 4?"
                     (row "Please use " (code (answer _____)) " and replace the blank field")
                     (row "with your command, for example: " (code (answer (+ 2 3))) "."))
                    (curry equal? (or (+ 1 4) (+ 4 1))))

   (simple-question (stack
                     "What if you need to add numbers 12 and 7 in Dr. Racket?"
                     "Please type in the command to do that."
                     (row "HINT: use " (code (answer _____)) " to type your answer again."))
                    (curry equal? (or (+ 12 7) (+ 7 12))))

   
   (simple-question (stack
                     "And one more example to practice:"
                     "what will be the command to add 67 and 32?")
                    (curry equal? (or (+ 67 32) (+ 32 67))))

   (yes-no-question (stack
                     "Also, in Dr.Racket you can add many numbers together: "
                     (code (+ 7 1 3))
                     "This command is equivalent to 7+1+3."
                     (row "Please answer " (code (yes)) " to continue."))
                    'yes)

   (simple-question (stack
                     (row "This creature " (scale 0.3 (random-dude))" was born in 2011.")
                     "Can you type the command to add all four single digits in it's birth year?" 
                     (row "HINT: please use " (code (answer _____)) " again and keep order of digits."))
                    (curry equal? (+ 2 0 1 1)))


   (yes-no-question (stack
                     "You doing great!"
                     "Subtraction command looks very simular to addition:"
                     (code (- 10 3))
                     (row "Please answer " (code (yes)) " to continue."))
                    'yes)

   (simple-question (stack
                     "Try to do subtraction command yourself."
                     "What will be a command to do 12-7?"
                     (row "HINT: please use " (code (answer _____)) " here."))
                    (curry equal? (- 12 7)))

   (yes-no-question (stack
                     "Awesome!"
                     "You can subtract many numbers in one comand too!"
                     (row "For example, a command to do 10-2-5 looks like: " (code (- 10 2 5)))
                     (row "Please answer " (code (yes)) " to continue."))
                    'yes)

   (simple-question (stack
                     "Now, please type the command to subtract 50-3-21."
                     (row "HINT: please use " (code (answer _____)) " here."))
                    (curry equal? (or (- 50 3 21) (- 50 21 3))))
))

(define (sum-sub-game-1)
  (apply start-quiz qs))

(module+ test
  (sum-sub-game-1))
