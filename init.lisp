(require :asdf)

(add-libpath! *DEFAULT-PATHNAME-DEFAULTS*)

(ql:quickload "cl-ws-wookie")
(asdf:test-system :cl-ws-wookie)
