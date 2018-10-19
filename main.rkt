#lang racket

(require ts-curric-common)
(define-quests
  tutorial
  circle-game)

(require "./quizzes.rkt")
(provide
 (all-from-out "./quizzes.rkt"))