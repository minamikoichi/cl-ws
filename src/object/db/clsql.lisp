(in-package :cl-ws-object)

(shadowing-import '(clsql::connect clsql::database))

(defmethod setup-db ((service <service>) &key name scheme type)
  (lt1 db (connect-db scheme type)
    (setf (gethash name (dbs-of service)) db)))

(defun connect-db (scheme type)
  (connect (list (namestring scheme))
	   :if-exists :old :database-type type))

(defmethod cleanup-db ((service <service>) name)
  (disconnect (get-db name))
  (setf (get-db name) nil))
