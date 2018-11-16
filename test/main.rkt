#lang racket

(require rackunit
         "../main.rkt"
         (except-in 2htdp/image circle))

(define (current-question-index)
  (index-of (context-quiz current) (context-question current)))

(check-equal? (the-details-game) (void) "the-details-game should return void")

(check-equal? (current-question-index) 0 "the current-question-index should be 0 when you just start a game")

(yes)

(check-equal? (current-question-index) 1 "the current-question-index should be 1 after answering yes")