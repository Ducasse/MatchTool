"
Style code as smalltalk expression
"
Class {
	#name : #MchToolCodeExpressionMode,
	#superclass : #MchToolMode,
	#category : #'MatchTool-Styling'
}

{ #category : #'initialize-release' }
MchToolCodeExpressionMode >> updateMode [
	self textArea shoutStyler styler
		beForSmalltalkCode;
		beForExpression.
]
