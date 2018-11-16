#lang racket

(provide the-numbers-game-2)

(require ts-racket
         2htdp/image
         "quizzes.rkt")

;Abstract this...
(define-syntax-rule (try-circle params ...)
  (try (circle params ...)))

; the-numbers-game-2
; Order of operations with addition and subtraction.
(define qs
  (list
   (yes-no-question (stack
                     "Let’s practice adding and subtracting numbers in Dr. Racket!"
                     (row "Please type " (code (yes)) " to proceed.")) 'yes)

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
                    (row "Please type " (code (yes)) " to proceed."))
                    'yes)
   
   (simple-question (stack
                     "Please type the command to add 5+1 in Dr. Racket."
                     (row "HINT: use " (code (answer _____)) " to type your answer."))
                    (curry equal? (or (+ 5 1) (+ 1 5))))

   (yes-no-question (stack
                     "Very good! Here are subtraction commands:"
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

   
   (yes-no-question (stack "Wonderful!"
                           "You mastered addition and subtraction!"
                           "You now ready to add more parentheses!")
                    'yes)

   (simple-question (stack
                     "In math we use parentheses () to show what operation will be done first."
                     "For example:"
                     "(4 – 2) + 1"
                     "= 2 + 1"
                     "= ?"
                     "What is (4 – 2) + 1 equal to?")
                    (curry equal? 3))

   (yes-no-question (stack
                     "In Dr.Racket code in inner parentheses will be run first:"
                     (code (+ (- 4 2) 1))
                     "Here is command breakdown:"
                     (row (code (- 4 2)) " will be run first")
                     (row (code (+ 2 1)) " computes final result.")
                     (row "Please type " (code (yes)) " to proceed."))
                    'yes)

   (yes-no-question (stack
                     "Now, let's look on this expression:"
                     "5 – (3 + 1)"
                     "Do we need to do addition (+) first to solve this?"
                     (row "Please type " (code (yes)) " to proceed."))
                    'yes)

   (simple-question (stack
                     "Please type in the command to do 3+1 in Dr. Racket."
                     (row "HINT: please use " (code (answer _____)) " to type your command."))
                    (curry equal? (or (+ 3 1) (+ 1 3))))

   (simple-question (stack
                     "That's right, to compute:"
                     "5 – (3 + 1)"
                     "we first need to do 3+1:"
                     (code (+ 3 1 ))
                     "Then we need to subtract that from 5:"
                     (code (- 5 ___))
                     (row "Please replace ___ with " (code (+ 3 1 )) "to finish the command.")
                     (row "HINT: please use " (code (answer _____)) " to type your command.")
                     "I know, it's a lot of parentheses :)")
                    (curry equal? (or (- 5 (+ 3 1)) (- 5 (+ 1 3)))))

   (simple-question (stack
                     "Fantastic! Yes, for an expression:"
                     "5 – (3 + 1)"
                     "the complete Dr. Racket command will look like:"
                     (code (- 5 (+ 3 1)))
                     "Let's try simular expression:"
                     "23 – (10 + 5)"
                     "Please type a Dr. Racket command to compute it."
                     (row "HINT: don't forget to use " (code (answer _____)) "."))
                    (curry equal? (or (- 23 (+ 10 5)) (- 23 (+ 5 10)))))
))

(define (the-numbers-game-2)
  (apply start-quiz qs))

(module+ test
  (the-numbers-game-2))
