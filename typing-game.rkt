#lang racket

(provide the-details-game)

(require happy-names
         ts-racket
         2htdp/image
         "quizzes.rkt")


(define r (random 100))

(define my-name
  (t (~a (string-join (map ~a (number->pair r)) "-")
         "-bot-" r)
     'purple))

(define qs
  (list
   (yes-no-question "Are you ready to test your eye for detail?"   'yes)

   (yes-no-question (stack
                     (row "Nice!  You got " (t "+1" 'darkgreen) " point already")
                     "This game will ask you a series of questions."
                     "Sometimes you'll have to type full response."
                     (row "Sometimes you'll have to answer " say-yes " or " say-no)
                     "Do you understand?")
                    'yes)
   
   (yes-no-question (stack
                     "NOTE! This game will be a little bit different each time you play."
                     "For example, here's a weird creature:"
                     (scale 0.5 (random-dude))
                     "But each time, you'll see a slightly different weird creature."
                     "Do you understand?")
                    'yes)

   (yes-no-question (stack
                     "The same thing is true for other questions."
                     "SOME of the questions will change each time you play."
                     "SOME (like this one) will stay the same"
                     "Do you understand?")
                    'yes)

   (yes-no-question (stack
                     "Oh, I forgot to tell you my name..."
                     "(HINT: You might need this later.)"
                     "My name is: "
                     my-name
                     "Did you write it down EXACTLY?")
                    'yes)
   
   
   (yes-no-question (stack
                     "Here's a warmup..."
                     (row "Is the sky sometimes " (t "blue" 'blue) "?"))
                    'yes)

   (yes-no-question (stack
                     "Nice! Here's another warmup..."
                     (row "Is the sky usually " (t "red" 'red) "?"))
                    'no)

   (simple-question (stack
                     (row "Okay, you're getting good at " say-yes " and " say-no " questions.")
                     "Let's try a harder one."
                     (row "Type the following EXACTLY: " (say-answer 'hello)))
                    'hello)
   
   (simple-question (stack
                     "Let's try a harder one."
                     "Type the following EXACTLY: "
                     (say-answer 'hello-world))
                    'hello-world)
   
   (simple-question (stack
                     "Let's try a even harder one."
                     "Type the following EXACTLY: "
                     (say-answer 'hello-world-my-name-is-bob77))
                    'hello-world-my-name-is-bob77)
   
   (yes-no-question (stack "Pop quiz: Is your name (in real life) bob77?"
                           "(HINT: Do not lie to me.  I will know.)")
                    'no)

   (yes-no-question (stack "Okay, you're getting good at paying attention to detail."
                           "You're ready for some coding questions now."
                           "Read the following expression:"
                           (code (circle 40 'solid 'red))
                           "I claim that this code has EXACTLY two parentheses."
                           "Do you agree?")
                    'yes)

   
   (yes-no-question (stack "Okay, let's shake things up!"
                           "Read the following expression:"
                           (code (circle (+ 20 20) 'solid 'red))
                           "I claim that this code has EXACTLY four parentheses."
                           "Do you agree?")
                    'yes)))


  

(define (the-details-game)
  (apply start-quiz qs))

(module+ test
  (the-details-game))