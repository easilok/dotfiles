#!/usr/bin/env bb

(ns wkst
  (:require [clojure.java.shell :refer [sh]]
            [clojure.string :as string]
            [cheshire.core :as json]))

(def somma-radios {:celtic "https://somafm.com/m3u/thistle.m3u"
                   :synph "https://somafm.com/m3u/synphaera256.m3u"
                   :metal "https://somafm.com/m3u/metal.m3u"
                   :groove "https://somafm.com/m3u/gsclassic.m3u"})

(defn start-stream[url]
  (try
    (sh "mpv" "--no-video" url)
    (catch Exception e
      (println (str "Error starting stream: " e)))))

(defn show-help []
  (let [help (str "Provide SomaFM radio to stream. "
                  "Available options are:\n"
                  (string/join "\n" (map #(str "  -" (name %)) (keys somma-radios))))]
    (println  help)))

(defn -main [args]
  (when (= 0 (count args))
    (show-help)
    (System/exit 1))

  (let [option (first args)]
    ; User requested help prompt
    (when (= option "--help")
      (show-help)
      (System/exit 0))

    (let [soma-stream-url (get somma-radios (keyword (string/lower-case option)))]
      (if soma-stream-url
        (do
          (println (str "Starting stream: " option))
          (start-stream soma-stream-url))         
        (do
          (println (str "Invalid radio option: " option))
          (show-help))))))

(-main *command-line-args*)
