#lang racket

(provide start-quiz
         question
         must-equal
         give-points
         show-me
         answer
         answer!)

(require 2htdp/image)


;Add to player (or the context).
;Allow question effects to change the last shown message to players...
;  Maybe have a last-shown-prompt and a last-shown-feedback

(struct player   (last-shown data)  #:transparent)
(struct question (prompt evaluate)  #:transparent)

(define (make-player [d 0])
  (player #f d))


(define (answer-question the-player
                         their-answer
                         the-question)

  (define affect
    (if the-question
      ((question-evaluate the-question) their-answer)
      identity))

  (struct-copy player
               the-player
               [data (affect (player-data the-player))]))


(define (maybe-call q)
  (if (procedure? q) (q) q))



(define (show-player the-player
                     the-question)
  
  (define prompt
    (maybe-call (if (question? the-question)
                    (question-prompt the-question)
                    the-question)))
  
  (struct-copy player the-player
               [last-shown (or prompt
                               (text "You're done!" 24 'green))]))


(define (t s)
  (text s 24 'black))



(struct context (player quiz question))

(define current #f)


(define (current-question)
  (context-question current))

(define (current-player)
  (context-player current))

(define (current-quiz)
  (context-quiz current))

(define (display-context c)
  #;(if (not (current-question))
      (displayln (t "Quiz finished! Score: " (player-data (context-player c))))
      (displayln (player-last-shown
                  (context-player c))))
  
  (displayln (display-player (context-player c))) )

(define (display-player p)
  (above/align "left"
   (t (~a "Current Score: " (player-data p)))
   (rectangle 300 10 'solid 'white)
   (or (player-last-shown p) empty-image)
   ))

(define (update-current! c)
  (set! current c)
  (display-context c))


(define (show-me)
  (update-current!
   (context
    (show-player (current-player)
                 (current-question))
    (current-quiz)
    (current-question))))

(define (start-quiz  #:player (the-player (make-player))
                     . questions)

  (update-current!
   (context (show-player
             the-player
             (t "Quiz started!  Use (show-me) to see the current question.\nUse (answer ___) to give an answer."))
            questions
            (first questions))))


(define (answer! a)
  (define remaining
    (member (current-question)
            (current-quiz)))

  (define next-question
    (and remaining
         (not (empty? remaining))
         (< 1 (length remaining))
         (second remaining)))

  (update-current!
   (context
    (show-player
     (answer-question (current-player) a (current-question))
     next-question)
    (current-quiz)
    next-question)))


(define answer answer!)



(define (give-points n)
  ;Show the player something positive or negative based on value of n...
  (curry + n))


(define (must-equal n #:reward right
                      #:penalty wrong)
  (lambda (a)
    (if ((and/c n) a)
        right
        wrong))) 




