"
Style code as pattern-based expression
"
Class {
	#name : #MchToolMatchExpressionMode,
	#superclass : #MchToolMode,
	#category : 'MatchTool-Styling'
}

{ #category : #'initialize-release' }
MchToolMatchExpressionMode >> updateMode [
	self textArea shoutStyler styler
		beForMatchCode;
		beForExpression
]
