#lang racket/base

(require rackunit "levenshtein.rkt")

; utils tests
(check-equal? (lmax (list 1 4 3 2)) 4 "lmax test")


; levenshtein distance tests
(check-equal? (distance "abcdef" "abcdef") 0 "One letter difference.")
(check-equal? (distance "abcdef" "aacdef") 1 "One letter difference.")
(check-equal? (distance "qwerty12345" "as90") 11 "Totaly different 11-letters strings.")
(check-equal? (distance "" "") 0 "0-length strings.")
(check-equal? (distance "poi3ie3" "k0g12") 7 "Another random-generated strings test.")
