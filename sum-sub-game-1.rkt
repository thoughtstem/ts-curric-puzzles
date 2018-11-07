#lang racket

(provide the-details-game
         (rename-out (try-circle circle)))

(require ts-racket
         2htdp/image
         "quizzes.rkt")

;Abstract this...
(define-syntax-rule (try-circle params ...)
  (try (circle params ...)))

; sum-sub-game-1
; Addition and substraction.

(define qs
  (list
   (yes-no-question (stack
                     "Let’s practice adding and substracting numbers in Dr. Racket!"
                     "But first, let me show you how to type your answer in this game."
                     (row "Please type " (code (yes)) " to proceed.")) 'yes)

   (yes-no-question (stack
                     "In this game sometimes you will need"
                     (row "to type your answer as " (code (yes)) " or " (code (no))".")
                     "Please type (yes) to proceed.") 'yes)

   (simple-question (stack
                     "For some questions you'll need to type in Dr. Racket commands: "
                     (row (code (answer _____))", where the blank field is the command.")
                     "Let's practice that!" 
                     "Please answer this question by typing the command to draw a circle:"
                     (code (answer (circle 20 "solid" "blue"))))
                    (curry equal? (circle 20 "solid" "blue")))


   (yes-no-question (stack
                     "Great job! Let's play with some numbers!"
                     "I’m sure you know how to add two numbers together, for example:"
                     "2+3 = 5."
                     "To do that in Dr. Racket we need to run following command:"
                     (code (+ 2 3))
                     "Please type (yes) to proceed.")
                    'yes)
   
   (simple-question (stack
                     (row "So, if a command to do 2+3 in Dr. Racket is "(code (+ 2 3)))
                     "what will be the command to sum numbers 1 and 4?"
                     (row "Please use the form of answer " (code (answer _____)) " and replace the blank field")
                     (row "with your command, for example:" (code (answer (+ 2 3))) "."))
                    (curry equal? (or (+ 1 4) (+ 4 1))))

   (simple-question (stack
                     "Now, what if you need to add numbers 12 and 7 in Dr. Racket? "
                     "Please type in the command to do that."
                     (row "HINT: use " (code (answer _____)) " to type your answer again."))
                    (curry equal? (or (+ 12 7) (+ 7 12))))

   
   (simple-question (stack
                     "And one more example to practice:"
                     "what will be the command to add 67 and 32?"
                     (row "HINT: use " (code (answer _____)) " to type your answer again."))
                    (curry equal? (or (+ 67 32) (+ 32 67))))

   (yes-no-question (stack
                     "Also, using addition command in Dr. Racket"
                     "you can add many numbers together: "
                     (code (+ 7 1 3))
                     "This command is equivalent to 7+1+3."
                     "Please type (yes) to continue.")
                    'yes)

   (simple-question (stack
                     (row "Now, this creature " (scale 0.3 (random-dude))" was born in 2011.")
                     "Can you type the command to sum all digits in it's birth year?" 
                     (row "HINT: please use " (code (answer _____)) " again and keep order of digits."))
                    (curry equal? (+ 2 0 1 1)))


   (yes-no-question (stack
                     "You doing great!"
                     "Let's try to substract numbers!"
                     "To substract two numbers, let's say 3 from 10:"
                     "10-3=7"
                     "in Dr. Racket you would need to use following command:"
                     (code (- 10 3))
                     "Looks very simular to addition, right?"
                     "Please answer (yes) to continue.")
                    'yes)

   (simple-question (stack
                     (row "Now, a Dr. Racket command to do 10-3 is " (code (- 10 3)))
                     "What will be a command to do 12-7?"
                     (row "HINT: please use " (code (answer _____)) " here."))
                    (curry equal? (- 12 7)))

   (yes-no-question (stack
                     "Awesome!"
                     "Remember how we could add several numbers in one command?"
                     (row "Like command to do 1+2+3+5 will be: " (code (+ 1 2 3 5)))
                     "You can substract many numbers in one comand too!"
                     (row "For example, a command to do 10-2-5 looks like: " (code (- 10 2 5)))
                      "Please answer (yes) to continue.")
                    'yes)

   (simple-question (stack
                     "Now, try substracting several numbers in one command yourself!"
                     "Please type the command to substract 50-3-21."
                     (row "HINT: don't forget to use " (code (answer _____)) " for your answer."))
                    (curry equal? (or (- 50 3 21) (- 50 21 3))))

   (yes-no-question (stack
                     "You've made an incredible progress!"
                     "Thank you for playing this puzzles!"
                     "Please type (yes) to finish!")
                    'yes)
))

(define (the-details-game)
  (apply start-quiz qs))

(module+ test
  (the-details-game))