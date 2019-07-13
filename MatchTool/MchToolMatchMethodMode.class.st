"
Style code as pattern-based method
"
Class {
	#name : #MchToolMatchMethodMode,
	#superclass : #MchToolMode,
	#category : #'MatchTool-Styling'
}

{ #category : #'initialize-release' }
MchToolMatchMethodMode >> updateMode [
	self textArea shoutStyler styler
		beForMatchCode;
		beForMethod.
]
