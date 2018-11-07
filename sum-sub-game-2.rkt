#lang racket

(provide the-details-game
         (rename-out (try-circle circle)))

(require ts-racket
         2htdp/image
         "quizzes.rkt")

;Abstract this...
(define-syntax-rule (try-circle params ...)
  (try (circle params ...)))

; sum-sub-game-2
; Order of operations with addition and substraction.
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
                     "Please answer this question by typing the command to draw a star:"
                     (code (answer (star 50 "solid" "purple"))))
                    (curry equal? (star 50 "solid" "purple")))


   (yes-no-question (stack
                     "Great job! Let's refresh how to add numbers in Dr. Racket!"
                     "You can use operator + to add two and more numbers:"
                     (code (+ 2 3))
                     (code (+ 34 5 6 3))
                     "This is equvalent to:"
                     "2 + 3 = 5"
                     "34 + 5 + 6 + 3 = 48"
                     "Please type (yes) to proceed.")
                    'yes)
   
   (simple-question (stack
                     "Please type the command to add 5+1 in Dr. Racket."
                     (row "HINT: use " (code (answer _____)) " to type your answer."))
                    (curry equal? (or (+ 5 1) (+ 1 5))))

   (yes-no-question (stack
                     "Looks great! Let's refresh how to substract numbers in Dr. Racket!"
                     "You can use operator - to substract two and more numbers:"
                     (code (- 2 1))
                     (code (- 30 5 1))
                     "This is equvalent to:"
                     "2 - 1 = 1"
                     "30 - 5 - 1 = 24"
                     "Please type (yes) to proceed.")
                    'yes)             

   (simple-question (stack
                     "To practice that, please type the command to do 10-5-1."
                     (row "HINT: use " (code (answer _____)) " to type your answer."))
                    (curry equal? (or (- 10 5 1) (+ 10 1 5))))

   
   (yes-no-question (stack
                     "Wonderful! You can add and substract numbers in Dr. Racket like a pro!"
                     "That's fantastic! Hope you're ready to move on!"
                     "Next we will add more parenthesis in our commands:)"
                     "Please type (yes) to proceed.")
                    'yes)

   (yes-no-question (stack
                     "Now, sometimes in math we use parenthesis ()"
                     "to show what operation will be done first."
                     "For example:"
                     "(4 – 2) + 1 = 3"
                     "here first we would do 4-2=2, and then add 1: 2+1=3."
                     "Please type (yes) to continue.")
                    'yes)

   (yes-no-question (stack
                     "Good news is that we use parentheis in Dr. Racket"
                     "the same way we do at math!"
                     "For example, the command to do:"
                     "(4 – 2) + 1 = 3"
                     "looks like this:"
                     (code (+ (- 4 2) 1))
                     "code in inner parenthesis will be run first:"
                     (code (- 4 2))
                     "and then 1 will be added to the result of that."
                     "Please type (yes) to continue.")
                    'yes)

   (yes-no-question (stack
                     "Now we will try to type Dr.Racket command "
                     "to compute expression with parenthesis."
                     "Let's look on this expression:"
                     "5 – (3 + 1)"
                     "Do we need to do addition (+) first to solve this?"
                     "Please answer (yes) or (no).")
                    'yes)

   (simple-question (stack
                     "Great! Yes, to solve an expression:"
                     "5 – (3 + 1)"
                     "we first need to do 3+1, because it's in parenthesis."
                     "Please type in the command to do 3+1 in Dr. Racket."
                     (row "HINT: please use " (code (answer _____)) " to type your command."))
                    (curry equal? (or (+ 3 1) (+ 1 3))))

   (simple-question (stack
                     "That's right, to compute:"
                     "5 – (3 + 1)"
                     "we first need to do 3+1:"
                     (code (+ 3 1 ))
                     "Then we need to substract that from 5:"
                     (code (- 5 ___))
                     (row "Please replace ___ with " (code (+ 3 1 )) "to finish the command.")
                     (row "HINT: please use " (code (answer _____)) " to type your command.")
                     "I know, it's a lot of parenthesis :)")
                    (curry equal? (or (- 5 (+ 3 1)) (- 5 (+ 1 3)))))

   (simple-question (stack
                     "Fantastic! Yes, for an expression:"
                     "5 – (3 + 1)"
                     "the complete Dr. Racket command will look like:"
                     (code (- 5 (+ 3 1)))
                     "Let's try simular expression:"
                     "23 – (10 + 5)"
                     "Please type a Dr. Racket command to compute it."
                     (row "HINT: please use " (code (answer _____)) " to type your command.")
                     (row "HINT-2: expressions  "  "5 – (3  + 1)")
                     (row "                                "  "23 – (10 + 5)")
                     "look very simular right? Only numbers are different.")
                    (curry equal? (or (- 23 (+ 10 5)) (- 23 (+ 5 10)))))

   (yes-no-question (stack
                     "Wow, that was great!"
                     "Thank you for playing this puzzles!"
                     "Please type (yes) to finish!")
                    'yes)
))

(define (the-details-game)
  (apply start-quiz qs))

(module+ test
  (the-details-game))