"
style code as Smalltalk method
"
Class {
	#name : #MchToolCodeMethodMode,
	#superclass : #MchToolMode,
	#category : #'MatchTool-Styling'
}

{ #category : #'initialize-release' }
MchToolCodeMethodMode >> updateMode [
	self textArea shoutStyler styler
		beForSmalltalkCode;
		beForMethod.

]
