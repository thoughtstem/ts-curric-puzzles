#lang racket

(require ts-curric-common)
(define-quests
  tutorial
  circle-game)

(require "./quizzes.rkt")
(require "./typing-game.rkt")
(require "./pictures-level-1.rkt")
(require "./pictures-level-2.rkt")

(provide
 (all-from-out "./quizzes.rkt")
 (all-from-out "./typing-game.rkt")
 (all-from-out "./pictures-level-1.rkt")
 (all-from-out "./pictures-level-2.rkt"))